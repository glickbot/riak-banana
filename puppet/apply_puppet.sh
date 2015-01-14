#!/bin/bash
puppet apply --verbose --debug --hiera_config /vagrant/puppet/hiera.yaml --modulepath=/vagrant/puppet/modules /vagrant/puppet/manifests/site.pp
