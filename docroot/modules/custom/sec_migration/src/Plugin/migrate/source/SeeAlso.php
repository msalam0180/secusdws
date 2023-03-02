<?php

namespace Drupal\sec_migration\Plugin\migrate\source;

use Drupal\migrate_source_csv\Plugin\migrate\source\CSV;

/**
 * Extracts Respondents See Also / Notes file urls
 *
 * @MigrateSource(
 *   id = "see_also",
 *   source_module = "sec_migration",
 * )
 */
class SeeAlso extends CSV {


  /**
   * {@inheritdoc}
   */
  public function initializeIterator() {
    $respondents = parent::initializeIterator();

    return $this->getYield($respondents);
  }

  /**
   * Prepares multiple rows per item
   *
   * @param \Generator $respondents
   *   The source respondents string object.
   *
   * @return \Generator
   *   A new row, one for each url in the source respondents string
   */
  public function getYield(\Generator $respondents) {
    $source_field = "respondents";
    if (!empty($this->configuration["source_field"])) {
      $source_field = $this->configuration["source_field"];
    }
    foreach ($respondents as $row) {

      //check if the structure includes post-url note
      if (preg_match("/ \( Note:.+\(.+\) , .+;?/i", $row[$source_field])) {
        $respondentsSnippet = explode(" Note:", $row[$source_field])[1];
        $delim = ";";
        if (!str_contains($respondentsSnippet, $delim)) $delim = ")";
        $urls = explode($delim, $respondentsSnippet);
        foreach ($urls as $url) {
          if (str_contains($url, 'http') || str_contains($url, 'public://') && !str_contains($url, "Comments received are available (")) {
            $regex = "/(^.+)?\((http.+?)\)(.+$)?/i";
            preg_match($regex, $url, $matches);
            if (!empty($matches) && isset($matches[2])) {
              if (str_contains($matches[2], "http") || str_contains($matches[2], "public://")) {
                $url = $matches[2];
                $label = trim($matches[1] . " " . $matches[3]);
                $label = preg_replace('/See also:? /i', '', $label);
                $invalidUrls = [
                  "acrobat.htm",
                  "cgi-bin/ruling-comments",
                  "sec.gov/comments",
                  "gpo.gov/fdsys",
                  "sec.gov/about/acrobat.htm",
                  ".htm#",
                  "goodbye.cgi?"
                ];
                $isInvalid = (str_replace($invalidUrls, '', $url) != $url);
                if (!$isInvalid) {
                  $new_row = $row;
                  $new_row["id"] = substr($url, 0, 255);
                  $new_row["url"] = $url;
                  $new_row["title"] = substr($label, 0, 255);
                  yield ($new_row);
                }
              }
            }
          }
        }
      } else {
        $delim = ")";
        $urls = explode($delim, $row[$source_field]);
        foreach ($urls as $url) {
          
          if ((str_contains($url, 'http') || str_contains($url, 'public://')) && !str_contains($url, "Comments received are available (")) {
            $regex = "/.+?(\( Note:?|PDF| \( PDF| ?;| ,| Appendix| Proposed|Additional Materials:|Finality|^ ?and|Final|Complaint:|\( Court|See also:?) ?(.*) \((http.+[^$]|public:.+[^$])/i";
            preg_match($regex, $url, $matches);
            if (!empty($matches)) {

              if (str_contains($matches[3], "http") || str_contains($matches[3], "public://")) {
                $url = trim($matches[3]);
                $label = trim($matches[1] . " " . $matches[2]);
                $label = str_ireplace(["( ", "See also:", "Note:", "Additional Materials:","; ", ", "],"", $label);

                $invalidUrls = [
                  "acrobat.htm",
                  "cgi-bin/ruling-comments",
                  "sec.gov/comments",
                  "gpo.gov/fdsys",
                  "https://www.sec.gov/about/acrobat.htm",
                  ".htm#",
                  "goodbye.cgi?"
                ];
               
                $isInvalid = (str_replace($invalidUrls, '', $url) != $url);
                if (!$isInvalid) {
                  $new_row = $row;
                  $new_row["id"] = substr($url, 0, 255);
                  $new_row["url"] = $url;
                  $new_row["title"] = substr($label, 0, 255);
                  yield ($new_row);
                }
              }
            }
          }
        }
      }
    }
  }


  /**
   * {@inheritdoc}
   */
  public function getIds() {
    return [
      'id' => [
        'type' => 'string',
        'alias' => 'id',
      ]
    ];
  }
}
