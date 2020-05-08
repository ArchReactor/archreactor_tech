#!/bin/bash

vagrant up --parallel
testing_command="vagrant ssh test-desktop -c 'cd /vagrant/ansible && ./deploy.sh -k -s ../../tests/vault'"
echo $testing_command
eval $testing_command
# Run twice because it can never find docker python until reconnect
if [[ "${?}" -ne 0 ]]
then
  eval $testing_command
fi
ERROR="${?}"

secs=5
while [ $secs -gt 0 ]; do
   echo -ne "\033[0K\rWaiting for: $secs seconds for services to load"
   sleep 1
   : $((secs--))
done

if [[ "${ERROR}" -ne 0 ]] 
then
  vagrant ssh test-desktop -c 'cd /vagrant/tests && ./trigger_sensu_checks.sh'
  ERROR="${?}"
fi


echo
echo
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
if [[ "${ERROR}" -ne 0 ]]
then
  echo -e "${RED}************** TEST FAILED **************${NC}"
else
  echo -e "${GREEN}************** TEST PASSED **************${NC}"
fi
echo
echo