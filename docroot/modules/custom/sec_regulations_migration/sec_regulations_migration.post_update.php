<?php
/**
 * This function sorts migrated Regulation content reference entities based on term weight of the Rule Type taxonomy
 * It can be executed via `drush eval "require 'modules/custom/sec_regulations_migration/sec_regulations_migration.post_update.php'; sec_regulations_migration_sort_rules();"`
 */
function sec_regulations_migration_sort_rules()
{
    $sorted = [];
    $rulemakingTerms = ['Final', 'Interim Final', 'Proposed', 'Concept', 'Interpretive'];    
    foreach ($rulemakingTerms as $term_name) {
        $term = \Drupal::entityTypeManager()->getStorage('taxonomy_term')
            ->loadByProperties(['name' => ($term_name)]);
        $termId = reset($term)->id();

        $entity_storage = \Drupal::entityTypeManager()->getStorage('node');
        $regulation_ids = $entity_storage->getQuery()
            ->condition('type', 'regulation')
            ->condition('field_rule_type', $termId)
            ->execute();
            
        if (!empty($regulation_ids)) {
            $entity_ids = \Drupal::entityTypeManager()->getStorage('node')->getQuery()
                ->condition('type', 'rule')
                ->condition('field_related_rule', $regulation_ids, "IN")
                ->execute();
        
            print_r("\nLoaded $term_name Rules...");
            foreach($entity_ids as $id) {
                $node = \Drupal\node\Entity\Node::load($id);
                //check if we've already sorted and skip this
                if(!in_array($node->id(), $sorted)) {
                    $regulations = $node->field_related_rule->referencedEntities();
                    //get first rule type and check if it qualifies for sorting
                    if (!empty($regulations) && count($regulations) > 1) {
                        //sort by taxonomy weight
                        usort($regulations, function ($a, $b) {
                            if (!empty($a->field_rule_type->entity)) {
                                if (!empty($b->field_rule_type->entity)) {
                                    return $a->field_rule_type->entity->getWeight() <=> $b->field_rule_type->entity->getWeight();
                                }
                            }
                        });
                        $node->set('field_related_rule', $regulations);
                        $node->save();
                        print_r("\nSorted related rules for node: " . $node->id());
                        $sorted[] = $node->id();
                    } else {
                        $regulations = null;
                        $node = null;
                    }
                } else {
                    $node = null;
                }
            }
        }
    }
}