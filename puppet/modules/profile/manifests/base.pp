class profile::base (


){
	include limits
	include stdlib
	class { '::oracle_java': }
	user { 'puppet':
		ensure => present,
		system => true
	}
     class { '::riak':
     	package_url => 'http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.0beta1/ubuntu/precise/riak_2.0.0beta1-1_amd64.deb',
     	riak_conf => { 
     	  ring_size => { value => 64 },
     	  search => { value => on },
     	  nodename => { value => "riak@${::fqdn}" },
     	  'listener.http.internal' => { ensure => absent },
     	  'listener.http.all' => { value => '0.0.0.0:8098' },
     	  'listener.protobuf.internal' => { ensure => absent },
     	  'listener.protobuf.all' => { value => '0.0.0.0:8087' }
     	}
     }
     class { '::riakbanana':

     }

     class { '::logstash':
       manage_repo => true,
       repo_version => '1.4'
     }

     class { '::logstash_contrib': }

     logstash::configfile { 'logstash-riak':
       content => template('profile/logstash-riak.erb')
     }
}
