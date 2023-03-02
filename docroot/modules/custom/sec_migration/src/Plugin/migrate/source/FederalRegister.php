<?php

namespace Drupal\sec_migration\Plugin\migrate\source;

use Drupal\migrate_source_csv\Plugin\migrate\source\CSV;
use GuzzleHttp\Exception\RequestException;

/**
 * Extracts Submit Comments records
 *
 * @MigrateSource(
 *   id = "federal_register",
 *   source_module = "sec_migration",
 * )
 */
class FederalRegister extends CSV {


  /**
   * {@inheritdoc}
   */
  public function initializeIterator() {
    $rows = parent::initializeIterator();

    return $this->getYield($rows);
  }

  /**
   * Filters rows with no comments
   *
   * @param \Generator $respondents
   *   The source id string object.
   *
   * @return \Generator
   *   A row for each comments note in the source respondents string
   */
  public function getYield(\Generator $rows) {
    $count = 0;
    foreach ($rows as $row) {
      if (isset($this->configuration['limit']) && $count >= $this->configuration['limit']) {
        break;
      }
      $count++;
      $new_row = $row;
      $titleField = isset($this->configuration['title_field']) ? $this->configuration['title_field'] : 'details';
      $idField = isset($this->configuration['id_field']) ? $this->configuration['id_field'] : 'id';
      $id = $row[$idField];
      if (isset($this->configuration['id_strip'])) {
        $id = str_replace($this->configuration['id_strip'],"", $id);
      }

      if ($id == "N/A") continue;
      try {

        //first check if file exists to avoid http call
        $cachedFile = "public://migration/federal_register/$id.json";
        if (file_exists($cachedFile)) {
          $raw_data = file_get_contents($cachedFile);
        } else {
          $httpClient = \Drupal::httpClient();

          //build the url fields requested
          $selectedFields = [
            "title",
            "type",
            "abstract",
            "document_number",
            "publication_date",
            "citation",
            "comments_close_on",
            "effective_on",
            "regulation_id_numbers",
            "docket_ids",
            "dates",
            "html_url",
            "pdf_url"
          ];
          $fields = join("&fields[]=", $selectedFields);
          $idQuery = $id;
          if (isset($this->configuration['id_prefix'])) {
            $idQuery = $this->configuration['id_prefix'] . $id;
          }
          $url = "https://www.federalregister.gov/api/v1/documents/?conditions[docket_id]=$idQuery&fields[]=$fields";

          $response = $httpClient->get($url, ['sink' => $cachedFile]);

          if ($response) {
            $raw_data = $response->getBody();
          }
        }

        if (!empty($raw_data)) {
          $body = json_decode($raw_data, TRUE);
          if (!empty($body["results"])) {
            $data = $body['results'][0];
            $title = mb_convert_encoding($data["title"], "UTF-8");
            $search = array("“","”","``","''",chr(145),chr(146),chr(147),chr(148),chr(151));
            $replace = array('"','"','"',"'","'",'"','"','-','');
            $title = str_replace($search, $replace, $title);
            //strip control characters
            $title = preg_replace('/[\x00-\x1F\x7F-\xFF]/', '', $title);


            $abstract = str_replace($search,$replace, $data["abstract"]);
            $new_row['title'] = $title;
            $new_row['type'] = $data["type"];
            $new_row['abstract'] = $abstract;
            $new_row['document_number'] = $data["document_number"];
            $new_row['publication_date'] = $data["publication_date"];
            $new_row['citation'] = $data["citation"];
            $new_row['comments_close_on'] = $data["comments_close_on"];
            $new_row['federal_register_version'] = $data["html_url"];

            if (isset($data["regulation_id_numbers"][0])) {
              $new_row['regulation_id_numbers'] = implode(", ", $data["regulation_id_numbers"]);
            }

            $allReleaseNumbers = [];
            $allFileNumbers = [];
            $hasMultipleReleaseNos = 0;
            $hasMultipleFileNos = 0;
            $counter = 0;
            foreach ($data["docket_ids"] as $docket_id) {
              //handle Release Numbers
              if (strpos($docket_id, "Release No") !== false|| $hasMultipleReleaseNos == 1) {
                $releaseNumber = $docket_id;
                if (strpos($docket_id, "Release Nos.") !== false) {
                  $hasMultipleReleaseNos = 1;
                }
                $releaseNumber = trim(preg_replace('/^(.+)?Release Nos?\.? /i', '', $releaseNumber));
                $allReleaseNumbers[] = $releaseNumber;
              }
              //handle file numbers
              if (strpos($docket_id, "File") !== false || $hasMultipleFileNos == 1) {
                $hasMultipleReleaseNos = 0;
                $fileNumber = $docket_id;
                if (strpos($docket_id, "File Nos.") !== false) {
                  $hasMultipleFileNos = 1;
                }
                $fileNumber = trim(preg_replace('/^(.+)?(File Nos?\.?|and )/i', '', $fileNumber));
                $allFileNumbers[] = $fileNumber;
              }
              $counter += 1;
            }
            $hasMultipleReleaseNos = 0;
            $hasMultipleFileNos = 0;
            $new_row["release_number"] = $allReleaseNumbers;
            $new_row["file_number"] = $allFileNumbers;
          } else {
            //no federal register data available for this item grab values from csv
            if (!empty($row[$titleField])) {
              $details = $row[$titleField];
              $regex = "/(?s)File Nos?\.:? (.+?(?= |,|;|\)|$))/";
              preg_match_all($regex, $details, $matches);

              if (!empty($matches[0])) {
                $fileNumber = $matches[1];
                $new_row["file_number"] = $fileNumber;
              }

              $regex = "/(?s)(.+?)(?=\( Note:|Note:|Release No|Other Release|See also|Submitted by:|File No|PDF version|Court of Appeals|The Securities and Exchange Commission \(\"\"Commission\"\"\) is |The U.S. Securities and Exchange Commission is |The Commission is |The Securities and Exchange Commission is |$)/i";
              $matches = [];
              preg_match($regex, $details, $matches);

              if (!empty($matches) && !empty($matches[0])) {
                $csv_title = htmlspecialchars_decode(trim($matches[0]));
                //remove any trailing open parenthesis
                if (str_ends_with($csv_title, "(")) {
                  $csv_title = substr($csv_title, 0, -1);
                }
                $new_row["title"] = $csv_title;
              }


              //check if Investment Company Act Deregulations
              if (preg_match('/^(.*?)(of 1940:|ceased to be an investment company|, 811-\w{1,6})(.+)$/i', $details)) {
                $dereg_title = preg_replace('/^(.*?)(of 1940:|ceased to be an investment company|, 811-\w{1,6})(.+)$/i', "$1$2", $details);
                $new_row["title"] = $dereg_title;
              }
            }

          }
        }
      } catch (RequestException $e) {
        //TODO add handling for exceptions
      }

      //add any related rules by parsing for Proposed Rule and Final Rule in csv details
      if (isset($row[$titleField])) {
        $regex = "/\s([A-Z0-9]{1,4}-[^-\(,\s\.;]+)(\s?\()?/i";
        $details = $row[$titleField];
        preg_match_all($regex, $details, $matches);
        if (isset($matches[1])) {
          $new_row["related_rules"] = $matches[1];
        }
      }
      //add current rule as release
      $new_row["related_rules"][] = $id;

      //remove unnecessary SRO titles from data
      if (preg_match('/^Self[-\s]Regulatory Organizations?/i', $new_row['title'] )) {
        $first_word = strtok($details, " ");
        if ($first_word !== "Self-Regulatory") {
          $rest_of_title = end(explode(" $first_word", $new_row["title"]));
          $shortTitle = "$first_word$rest_of_title";
          $new_row["title"] = $shortTitle;
        }
        //handle titles that don't match details to fed register
        $new_row["title"] = str_replace("NoticeSelf-Regulatory", "Self-Regulatory", $new_row["title"]);

        //double check
        if (preg_match('/^Self[-\s]Regulatory Organizations?/i', $new_row["title"] )) {
          $new_row["title"] = preg_replace("/^Self[-\s]Regulatory Organizations?[;|\.|,].+(Notice|Order|Correction|Designation|Declaration|Suspension|Solicitation|Request)(.+)?$/", '$1$2', $new_row['title']);
        }

      }

      //fix any long titles
      if (strlen($new_row["title"]) > 255) {
        $new_row["title"] = substr($new_row["title"], 0, 255);
      }
      yield ($new_row);

    }
  }


  /**
   * {@inheritdoc}
   */
  public function getIds() {
    $idField = isset($this->configuration['id_field']) ? $this->configuration['id_field'] : 'id';
    return [
      "$idField" => [
        'type' => 'string',
        'alias' => "$idField",
      ]
    ];
  }
}
