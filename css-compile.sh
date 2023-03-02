#!/bin/bash
echo "Begin CSS compiling"
echo "Adding Acquia as a remote repository"
git remote add acquia secgov@svn-19092.prod.hosting.acquia.com:secgov.git
echo "Checking out $CI_BUILD_REF_NAME"
git clean -fd;
git checkout $CI_BUILD_REF_NAME -f;
git reset --hard
echo "Pulling latest from Gitlab master"
git pull origin $CI_BUILD_REF_NAME -f;
echo "Pulling latest from Acquia master"
git pull acquia $CI_BUILD_REF_NAME;
echo "Setup Node"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 16.18.1
nvm use 16.18.1
echo "Node version"
node -v
echo "Gulp version"
gulp -v
echo "***Compiling the secgov theme SASS using gulp***"
cd docroot/themes/custom/secgov
npm install
gulp sass
cd ../../../..
echo "***Building USWDS SEC SASS using gulp***"
cd docroot/themes/custom/uswds_sec
npm install
npm run build
cd ../../../..
echo "***Compiling the investorgov SASS using gulp***"
cd docroot/sites/investorgov/themes/custom/investor
npm install
gulp sass
cd ../../../../../../
echo "Committing the compiled Files."
git add -A
git add --force docroot/themes/custom/uswds_sec/dist
git add --force docroot/sites/investorgov/themes/custom/investor/css
git add --force docroot/themes/custom/secgov/css
git status
git commit -m "Compiling sass and js files."
echo "Pushing latest to Acquia master"
git push --force acquia $CI_BUILD_REF_NAME;

