#!/bin/bash

vagrant plugin install vagrant-hosts
vagrant up --parallel
testing_command="vagrant ssh test-desktop -c 'cd /vagrant/ansible && ./deploy.sh -k -s ../../tests/vault'"

# Run multiple times because it can never find docker python until second try.
# Also somtimes the test starts before Virtual Box is ready
TRIES=3
ERROR=1
while [[ "${ERROR}" -ne 0 && "${TRIES}" -gt 0 ]]; do
  : $((TRIES--))
  echo $testing_command
  eval $testing_command
  ERROR="${?}"
done

DELAY=5
while [[ "${DELAY}" -gt 0 ]]; do
   echo -ne "\033[0K\rWaiting for: $DELAY seconds for services to load"
   sleep 1
   : $((DELAY--))
done

if [[ "${ERROR}" -eq 0 ]] 
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
