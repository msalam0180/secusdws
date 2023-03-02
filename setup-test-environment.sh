#!/bin/sh
echo "Running script as "
whoami
echo "Setting up test environment on Gitlab"
cd ~/sec/secgov/
echo "Checking out $CI_BUILD_REF_NAME"
git clean -fd;
git fetch --all
git checkout $CI_BUILD_REF_NAME -f;
git reset --hard origin/$CI_BUILD_REF_NAME
echo "Pulling latest from Gitlab master"
git pull origin $CI_BUILD_REF_NAME -f;
echo "Pulling latest from Acquia master"
git pull acquia $CI_BUILD_REF_NAME;
cd ~/sec/secgov/docroot
echo "Running cr on test env"
~/vendor/bin/drush cr -l secgov;
~/vendor/bin/drush cr -l investorgov;
echo "Running updb on test env"
~/vendor/bin/drush updb -y -l secgov;
~/vendor/bin/drush updb -y -l investorgov;
echo "Running cim on test env"
~/vendor/bin/drush cim -y -l secgov;
~/vendor/bin/drush cim -y -l investorgov;
echo "Test environment is ready for testing of $CI_BUILD_REF_NAME branch"
cd ~/sec/secgov/
