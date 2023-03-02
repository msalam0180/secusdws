#!/bin/bash

# Get the lando logger
. /helpers/log.sh

# Install Acquia CLI v1.12
lando_green "Running appserver build..."
curl -OL https://github.com/acquia/cli/releases/download/2.1.0/acli.phar && lando_pink '*****Acquia CLI - Pull complete.*****' # Pull Acquia CLI
chmod +x acli.phar && lando_pink '*****Acquia CLI - Make file executable complete.*****' # Make the file executable
mv acli.phar /usr/local/bin/acli && lando_pink '*****Acquia CLI - File move complete.*****' # Rename the file and move it to a location that is globally accessible.

# Install node v16 and gulp-cli v2.3
echo ""
lando_green "Install node v16 and gulp-cli v2.3"
curl -sL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs
npm install --global gulp-cli@2.3

# Copy local settings.local.php
cp /app/.lando-config/sec.settings.local.php /app/docroot/sites/secgov/settings.local.php && lando_pink '*****SEC Settings Local File copied.*****'
cp /app/.lando-config/investor.settings.local.php /app/docroot/sites/investorgov/settings.local.php && lando_pink '*****Investor Settings Local File copied.*****'
