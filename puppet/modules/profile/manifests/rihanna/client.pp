class profile::rihanna::client inherits profile::base {

	include apt

	stage { "pre":
		before => Stage["logstash"]
	}

	stage { "logstash":

	}

  class { '::oracle_java':
		stage => pre
	}

	class { '::logstash':
		stage => logstash,
		manage_repo => true,
		repo_version => '1.4'
	} ~>

	class { '::logstash_contrib':
		stage => logstash
	}

	logstash::configfile { 'logstash-riak':
		content => template('profile/logstash-riak.erb')
	}

	file { 'rsyslog config':
		path => "/etc/rsyslog.d/99-logstash.conf",
		content => template("riakbanana/99-logstash.conf.erb"),
		ensure => present,
		notify => Service['rsyslog'],
	}

	service { 'rsyslog': }

}
