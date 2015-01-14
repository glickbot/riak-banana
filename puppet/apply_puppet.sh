#!/bin/bash
puppet apply --verbose --debug --hiera_config /opt/puppet/hiera.yaml --modulepath=/opt/puppet/modules /opt/puppet/manifests/site.pp
