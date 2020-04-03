#!/bin/bash

vagrant up
vagrant ssh test-desktop -c "ls /vagrant"