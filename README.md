riak-banana
===========

Riak2.0 + LucidWorks/banana

#### Status: WIP

##### Issues:
- dashboards should be stored in Riak
- actual entry values should be pulled from Riak instead of Solr
- break out riak, riakbanana, and java modules
- add example multi-node deployment
- add how-to without vagrant
- add OS tunings
- ~~nginx & logstash need to be restarted appropriately via puppet~~
- ~~hacky librarian-puppet issues due to windows /vagrant mounts should be worked around~~
- ~~race condition during 'vagrant up', need to run 'vagrant provision' after~~
- ~~uses ugly 'files' directory, referencing "/vagrant/files" in puppet modules, need to clean up~~
- ~~hitting local solr instead of Riak solr query interface, due to Banana requesting Solr Admin API calls~~

#### Notes
The goal is to hook in LucidWorks/banana into Riak2.0's solr interface, use Riak to store dashboards, etc, and riak to submit log data.

Currently Functional, needs cleaning/testing

##### Creates 2 Nodes:

###### Rihanna01 - Server:
Installs and configures:
- Riak2.0, sets up default search index for bucket 'logstash_logs'
- Nginx to serve static banana files & route solr non-query api endpoints for banana
- https://github.com/LucidWorks/banana/

###### Client02 - Client (creates logs):
Installs and configures:
- Logstash
- Logstash contribs
- Syslog -> Riak logstash output plugin

###### Requirements

requires: vagrant, virtualbox

Vagrant box is based on Ubuntu

Vagrantfile tested on Windows & Mac

#### Usage:

```
git clone https://github.com/glickbot/riak-banana
cd riak-banana
vagrant up
```

Navigate to ```http://http://10.42.0.6/```

#### Configuration:

Configuration can be specified in riak-banana/puppet/hiera/common.yaml

Uses "roles" and "profiles" modules to apply modules to nodes
