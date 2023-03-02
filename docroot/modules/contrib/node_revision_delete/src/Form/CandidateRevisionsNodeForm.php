<?php

namespace Drupal\node_revision_delete\Form;

use Drupal\Component\Utility\Xss;
use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Url;
use Drupal\node_revision_delete\Utility\Donation;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\node_revision_delete\NodeRevisionDeleteInterface;
use Drupal\Core\Link;
use Drupal\Core\Datetime\DateFormatterInterface;
use Drupal\Core\Render\RendererInterface;
use Drupal\node\NodeInterface;

/**
 * Class CandidateRevisionsForm.
 *
 * @package Drupal\node_revision_delete\Form
 */
class CandidateRevisionsNodeForm extends FormBase {

  /**
   * The entity type manager service.
   *
   * @var \Drupal\Core\Entity\EntityTypeManagerInterface
   */
  protected EntityTypeManagerInterface $entityTypeManager;

  /**
   * The node revision delete interface.
   *
   * @var \Drupal\node_revision_delete\NodeRevisionDeleteInterface
   */
  protected NodeRevisionDeleteInterface $nodeRevisionDelete;

  /**
   * The date formatter service.
   *
   * @var \Drupal\Core\Datetime\DateFormatterInterface
   */
  protected DateFormatterInterface $dateFormatter;

  /**
   * The renderer service.
   *
   * @var \Drupal\Core\Render\RendererInterface
   */
  protected RendererInterface $renderer;

  /**
   * Constructor.
   *
   * @param \Drupal\Core\Entity\EntityTypeManagerInterface $entity_type_manager
   *   The entity type manager.
   * @param \Drupal\node_revision_delete\NodeRevisionDeleteInterface $node_revision_delete
   *   The node revision delete.
   * @param \Drupal\Core\Datetime\DateFormatterInterface $date_formatter
   *   The date formatter service.
   * @param \Drupal\Core\Render\RendererInterface $renderer
   *   The renderer service.
   */
  public function __construct(
    EntityTypeManagerInterface $entity_type_manager,
    NodeRevisionDeleteInterface $node_revision_delete,
    DateFormatterInterface $date_formatter,
    RendererInterface $renderer
  ) {
    $this->entityTypeManager = $entity_type_manager;
    $this->nodeRevisionDelete = $node_revision_delete;
    $this->dateFormatter = $date_formatter;
    $this->renderer = $renderer;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('entity_type.manager'),
      $container->get('node_revision_delete'),
      $container->get('date.formatter'),
      $container->get('renderer')
    );
  }

  /**
   * {@inheritdoc}
   */
  public function getFormId(): string {
    return 'node_revision_delete_candidates_revisions_node';
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state, ?string $node_type = NULL, ?NodeInterface $node = NULL): array {
    // Table header.
    $header = [
      $this->t('Revision ID'),
      [
        'data' => $this->t('Revision'),
        // Hide the description on narrow width devices.
        'class' => [RESPONSIVE_PRIORITY_MEDIUM],
      ],
      [
        'data' => $this->t('Operations'),
        // Hide the Operations on narrow width devices.
        'class' => [RESPONSIVE_PRIORITY_MEDIUM],
      ],
    ];

    // Getting the nid.
    $nid = $node->id();

    // Getting the node revisions.
    $revisions = $this->nodeRevisionDelete->getCandidatesRevisionsByNids([$nid]);

    $rows = [];
    foreach ($revisions as $revision) {
      // Loading the revisions.
      /** @var \Drupal\Core\Entity\RevisionLogInterface $revision */
      $revision = $this->entityTypeManager->getStorage('node')->loadRevision($revision);

      $username = [
        '#theme' => 'username',
        '#account' => $revision->getRevisionUser(),
      ];

      // Build link to view revision.
      $date = $this->dateFormatter->format($revision->revision_timestamp->value, 'short');
      $revision_url = new Url('entity.node.revision', ['node' => $revision->id(), 'node_revision' => $revision->getRevisionId()]);
      $revision_link = Link::fromTextAndUrl($date, $revision_url)->toRenderable();

      $revision_info = [
        '#type' => 'inline_template',
        '#template' => '{% trans %}{{ date }} by {{ username }}{% endtrans %}{% if message %}<p class="revision-log">{{ message }}</p>{% endif %}',
        '#context' => [
          'date' => $this->renderer->renderPlain($revision_link),
          'username' => $this->renderer->renderPlain($username),
          'message' => [
            '#markup' => $revision->revision_log->value,
            '#allowed_tags' => Xss::getHtmlTagList(),
          ],
        ],
      ];

      // Getting the vid.
      $vid = $revision->getRevisionId();
      // The route parameters.
      $route_parameters_destination = [
        'node_type' => $node_type,
        'node' => $nid,
      ];

      // Return to the same page after save the content type.
      $destination = Url::fromRoute('node_revision_delete.candidate_revisions_node', $route_parameters_destination)->toString();
      $destination_options = [
        'query' => ['destination' => $destination],
      ];

      // The route parameters.
      $route_parameters_dropbutton = [
        'node' => $nid,
        'node_revision' => $vid,
      ];

      $dropbutton = [
        '#type' => 'dropbutton',
        '#links' => [
          // Action to delete revisions.
          'delete' => [
            'title' => $this->t('Delete'),
            'url' => Url::fromRoute('node.revision_delete_confirm', $route_parameters_dropbutton, $destination_options),
          ],
        ],
      ];

      $rows[$vid] = [
        $vid,
        ['data' => $revision_info],
        ['data' => $dropbutton],
      ];
    }

    $node_url = $node->toUrl()->toString();
    $caption = $this->t('Candidates revisions for node <a href=":url">%title</a>', [':url' => $node_url, '%title' => $node->getTitle()]);

    $form['candidate_revisions'] = [
      '#type' => 'tableselect',
      '#caption' => $caption,
      '#header' => $header,
      '#options' => $rows,
      '#empty' => $this->t('There are not candidates revisions to be deleted.'),
      '#sticky' => TRUE,
    ];

    $form['actions']['#type'] = 'actions';

    $form['actions']['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('Delete revisions'),
      '#button_type' => 'primary',
    ];

    // Adding donation text.
    $form['#prefix'] = Donation::getDonationText();

    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state): void {
    // Get selected revisions.
    $candidate_revisions = array_filter($form_state->getValue('candidate_revisions'));

    if (count($candidate_revisions)) {
      // Add the batch.
      batch_set($this->nodeRevisionDelete->getRevisionDeletionBatch($candidate_revisions, FALSE));
    }
  }

}
