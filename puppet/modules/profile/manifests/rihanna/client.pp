class profile::rihanna::client inherits profile::base {

	include apt

  class { '::oracle_java':
	} ~>

	class { '::logstash':
		manage_repo => true,
		repo_version => '1.4'
	} ~>

	class { '::logstash_contrib':

	}

	logstash::configfile { 'logstash-riak':
		content => template('profile/logstash-riak.erb'),
		notify => Service['logstash'],
		require => Package['logstash']
	}

	file { 'rsyslog config':
		path => "/etc/rsyslog.d/99-logstash.conf",
		content => template("riakbanana/99-logstash.conf.erb"),
		ensure => present,
		notify => Service['rsyslog'],
	}

	service { 'rsyslog': }

}
