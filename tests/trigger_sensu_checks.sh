#!/bin/bash
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

# echo "This script executes all sensu checks."
# echo "Then checks the results of those checks."
# echo "Exiting with a non zero error on failure."

SENSU_USER="admin"
SENSU_PASSWORD="test_password"
SENSU_URL="http://archreactor.org:8080"


ACCESS_TOKEN=$(curl -u "$SENSU_USER:$SENSU_PASSWORD" $SENSU_URL/auth 2> /dev/null | jq -r '.access_token' 2> /dev/null)
if [ "${?}" -ne "0" ] 
then
  echo -e "${RED}**\nError getting access token. Check URL, username and password.\n**${NO_COLOR}"
  exit 1
fi

LIST_OF_CHECKS=$( \
curl -H "Authorization: Bearer $ACCESS_TOKEN" \
$SENSU_URL/api/core/v2/checks \
2> /dev/null \
| jq -r '.[] | .metadata.name' )

for CHECK_NAME in $LIST_OF_CHECKS
do
  echo "Running check $CHECK_NAME"
  curl -X POST \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -d "{\"check\": \"$CHECK_NAME\"}" \
  $SENSU_URL/api/core/v2/namespaces/default/checks/$CHECK_NAME/execute &> /dev/null
done

secs=5
while [ $secs -gt 0 ]; do
   echo -ne "\033[0K\rWaiting for: $secs seconds for checks to complete"
   sleep 1
   : $((secs--))
done

CHECK_RESULTS=$( \
curl -H "Authorization: Bearer $ACCESS_TOKEN" \
$SENSU_URL/api/core/v2/events -G \
--data-urlencode 'fieldSelector=event.check.status != "0"' \
2> /dev/null )

ERROR_COUNT=$( \
echo "$CHECK_RESULTS" \
| jq '. | length' )

if [ "${ERROR_COUNT}" -ne 0 ]
then
  echo
  echo
  echo "The following Sensu checks failed:"
  echo -e "${RED}"
  echo "$CHECK_RESULTS" | jq -r ".[] | .check.metadata.name + \": \" + .check.output"
  echo -e "${NO_COLOR}"
  exit 1
fi

echo -e "${GREEN}All Sensu checks passed!${NO_COLOR}"
