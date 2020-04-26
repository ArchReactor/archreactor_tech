#!/bin/bash

vagrant up --parallel
vagrant ssh test-desktop -c 'cd /vagrant/ansible && ./deploy.sh -k "" -s ../../tests/vault'
ERROR="${?}"
echo
echo
echo
echo
echo
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
if [[ "$ERROR" -ne 0 ]]
then
  echo -e "${RED}************** TEST FAILED **************${NC}"
else
  echo -e "${GREEN}************** TEST PASSED **************${NC}"
fi
echo
echo