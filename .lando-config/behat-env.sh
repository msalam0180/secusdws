#! /bin/bash

start=$'tooling:\n  behat-sec:\n    env:'

secEnv=$(lando info | sed -nr 's/.*(http:\/\/sec.lndo.site:.*\/).*/\1/p')
behatSEC=$'\n       BEHAT_PARAMS: \'{"extensions": {"Behat\\\\MinkExtension": {"base_url": "'$secEnv'"},"Drupal\\DrupalExtension":{"drupal":{"drupal_root":"/app/docroot"},"drush":{"alias":"local.sec"}}}}'\'''

middle=$'\n  behat-investor:\n    env:'

investorEnv=$(lando info | sed -nr 's/.*(http:\/\/investor.lndo.site:.*\/).*/\1/p')
behatInvestor=$'\n       BEHAT_PARAMS: \'{"extensions": {"Behat\\\\MinkExtension": {"base_url": "'$investorEnv'"},"Drupal\\DrupalExtension":{"drupal":{"drupal_root":"/app/docroot"},"drush":{"alias":"local.investor"}}}}'\'''

echo "$start $behatSEC $middle $behatInvestor" > .lando.local.yml

# Example output to .lando.local.yml:
#
# tooling:
#   behat-sec:
#     env:
#        BEHAT_PARAMS: '{"extensions": {"Behat\\MinkExtension": {"base_url": "http://sec.lndo.site:8000/"},"Drupal\\DrupalExtension":{"drupal":{"drupal_root":"/app/docroot"},"drush":{"alias":"local.sec"}}}}'
#   behat-investor:
#     env:
#        BEHAT_PARAMS: '{"extensions": {"Behat\\MinkExtension": {"base_url": "http://investor.lndo.site:8000/"},"Drupal\\DrupalExtension":{"drupal":{"drupal_root":"/app/docroot"},"drush":{"alias":"local.investor"}}}}'
