class riakbanana::install inherits riakbanana {

# logstash's riak output doesn't currently understand bucket types, so we'll
#    install them directly via bucket properties

  package { 'git':
    ensure => installed
  }

  exec { 'install banana':
    command => "git clone https://github.com/LucidWorks/banana.git",
    cwd => "${solr_webapp_dir}",
    creates => "${solr_webapp_dir}/banana",
    require => Package['git'],
    notify => File['banana dashboard'],
  }

  file { 'banana dashboard':
    path => "${solr_webapp_dir}/banana/src/app/dashboards/default.json",
    content => template("riakbanana/dashboard.json.erb"),
    ensure => present
  }

  file { 'rsyslog config':
    path => "/etc/rsyslog.d/99-logstash.conf",
    content => template("riakbanana/99-logstash.conf.erb"),
    ensure => present,
    notify => Service['rsyslog'],
  }

  service { 'rsyslog': }

  exec { 'install schema':
    command => "curl -XPUT -i '${riak_url}/search/schema/${index}' -H 'content-type: application/xml' --data-binary @/vagrant/files/logstash_logs.xml",
    unless => "curl '${riak_url}/search/schema/${index}' -f",
  }

  exec { 'install index':
    command => "curl -XPUT -i '${riak_url}/search/index/${index}' -H 'content-type: application/json' -d '{\"schema\":\"${index}\"}'",
    unless => "curl '${riak_url}/search/index/${index}' -f",
    require => Exec['install schema'],
    notify => Exec['configure bucket']
    #notify => Exec['create bucket-type']
  }

  #exec { 'create bucket-type':
	#    command => "riak-admin bucket-type create data '{\"props\":{}}'",
  #    unless => "riak-admin bucket-type status data", # bucket-type returns reverse error code
	#    notify => Exec['activate bucket-type'],
  #    refreshonly => true
  #}

  #exec { 'activate bucket-type':
  #  command => "riak-admin bucket-type activate data",
  #  notify => Exec['configure bucket'],
  #  refreshonly => true
  #}

  exec { 'configure bucket':
    command => "curl -i -H 'content-type: application/json' -XPUT '${riak_url}/buckets/${index}/props' -d '{\"props:\":{\"search_index\":\"${index}\"}}'",
    refreshonly => true
  }

  #exec { 'configure bucket-type':
  #  command => "curl -i -H 'content-type: application/json' -X PUT '${riak_url}/types/data/buckets/${index}/props' -d '{\"props\":{\"search_index\":\"${index}\"}}'",
  #  refreshonly => true
  #}
}
