#! /bin/bash

# Get the lando logger
. /helpers/log.sh

# Compiling and building themes on lando
lando_green "*****START - SEC theme build*****"
cd /app/docroot/themes/custom/secgov
npm install && npm run compile && lando_green "*****SEC theme build complete.*****"

lando_green "*****START - Investor theme build*****"
cd /app/docroot/sites/investorgov/themes/custom/investor
npm install && npm run compile && lando_green "*****Investor theme build complete.*****"

lando_green "*****START - USWDS SEC theme build*****"
cd /app/docroot/themes/custom/uswds_sec
npm install && npm run build && lando_green "*****USWDS SEC theme build complete.*****"