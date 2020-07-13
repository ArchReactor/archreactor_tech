## Tests require **Vagrant** and **Virtual Box**
[https://www.virtualbox.org/](https://www.virtualbox.org/)

[https://www.vagrantup.com/](https://www.vagrantup.com/)

### Also install vagrant-hosts plugin

```vagrant plugin install vagrant-hosts```

### Run the test script

This may take an hour to run. It needs to download 3 virtual boxes. One for each server and one desktop for testing. See [Vagrantfile](Vagrantfile) for details

```cd tests && ./test.sh```

This will add checks to Sensu and then wait for the results of those checks..