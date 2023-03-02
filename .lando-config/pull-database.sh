#! /bin/bash

# Get the lando logger
. /helpers/log.sh

project="$1"
env="$2"
uri=""
siteAlias=""
fileName=""

echo $'What project do you want to pull Database for?\n[0] Exit\n[1] SEC\n[2] Investor'
read project
case $project in 1 | 2)
  echo "Great! [$project]"
  echo ""
  ;;
*)
  lando_red "Error! Invalid Project."
  exit
  ;;
esac

lando_pink "Getting Environment Information."
acli api:applications:environment-list secgov > /app/.lando-config/secgov-envs.txt && lando_green "Success!"
declare environments=($(cat /app/.lando-config/secgov-envs.txt | sed -nr -e 's/.*"label": "(.*)",/\1/p'))
declare branches=($(cat /app/.lando-config/secgov-envs.txt | sed -nr 's/.*"path": "(.*)",/\1/p'))
envPrompt=$'Which environment?\n[0] Exit\n'

for i in ${!environments[@]};
do
  label=${environments[$i]}
  gitbranch=${branches[$i]}
  if [ $label == "Prod" ]; then
    envPrompt+="[1] prod     - currently on branch: $gitbranch"$'\n'
  elif [ $label == "Stage" ]; then
    envPrompt+="[2] stage    - currently on branch: $gitbranch"$'\n'
  elif [ $label == "Dcmtrain" ]; then
    envPrompt+="[3] train    - currently on branch: $gitbranch"$'\n'
  elif [ $label == "Dev" ]; then
    envPrompt+="[4] dev      - currently on branch: $gitbranch"$'\n'
  elif [ $label == "Dcmdev1" ]; then
    envPrompt+="[5] dev1     - currently on branch: $gitbranch"$'\n'
  elif [ $label == "Dcmtest1" ]; then
    envPrompt+="[6] test1    - currently on branch: $gitbranch"$'\n'
  elif [ $label == "Investor" ]; then
    envPrompt+="[7] investor - currently on branch: $gitbranch"$'\n'
  fi
done

if [[ $project == "1" || "$project" == "2" ]]; then
  if [ $project == "1" ]; then
    uri=sec.gov
    fileName=secdb
  elif [ $project == "2" ]; then
    uri=investor.gov
    fileName=investordb
  fi
  # echo $'Which environment?\n[0] Exit\n[1] prod\n[2] stage\n[3] train\n[4] dev\n[5] dev1\n[6] test\n[7] investor'
  echo "$envPrompt" | sort | sed 's@\\@@g'
  rm /app/.lando-config/secgov-envs.txt
fi

read env
case $env in 1 | 2 | 3 | 4 | 5 | 6 | 7)
  echo "Great! [$env]"
  ;;
*)
  lando_red "Error! Invalid Environment."
  exit
  ;;
esac

if [ $env == "1" ]; then
  siteAlias=secgov.prod
elif [ $env == "2" ]; then
  siteAlias=secgov.test
elif [ $env == "3" ]; then
  siteAlias=secgov.dcmtrain
elif [ $env == "4" ]; then
  siteAlias=secgov.dev
elif [ $env == "5" ]; then
  siteAlias=secgov.dcmdev1
elif [ $env == "6" ]; then
  siteAlias=secgov.dcmtest1
elif [ $env == "7" ]; then
  siteAlias=secgov.investor
fi

lando_pink "Pulling Database."
echo ""

msg1="*****Don't forget to run import command*****"
msg2=$'\n\n'
msg3="lando db-import $fileName.sql -h $fileName"
msg4=$'\n\n'

# /usr/local/bin/acli remote:drush $siteAlias -- --uri=$uri sql-dump --extra=--no-tablespaces > $fileName.sql && lando_green "$msg1 $msg2 $msg3 $msg4" || lando_red "Pull failed."

## Once all site is on drush 10 switch to this command to exlude pulling cache tables
/usr/local/bin/acli remote:drush $siteAlias -- --uri=$uri sql-dump --structure-tables-list=cache*,webform_* --extra-dump=--no-tablespaces > $fileName.sql && lando_green "$msg1 $msg2 $msg3 $msg4" || lando_red "Pull failed."
