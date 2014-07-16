riak-banana
===========

Riak2.0 + LucidWorks/banana

#### Notes
The goal is to hook in LucidWorks/banana into Riak2.0's solr interface, use Riak to store dashboards, etc, and riak to submit log data.

Currently Functional, needs cleaning/testing

Installs and configures Riak2.0, sets up default search index for bucket 'logstash_logs'

Installs and configures Logstash + Logstash contribs, configures riak logstash plugin

Installs banana

#### Usage:

requires: puppet 3, https://github.com/rodjek/librarian-puppet, vagrant

Right now only works on ubuntu

```
git clone https://github.com/glickbot/riak-banana
cd riak-banana
librarian-puppet install
vagrant up
ssh-with-fwds
```

Navigate to ```http://localhost:8093/internal_solr/banana/src/index.html```

Use ```http://localhost:8093/internal_solr``` for solr webapp
