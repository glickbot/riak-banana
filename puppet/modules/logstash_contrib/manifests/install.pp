class logstash_contrib::install inherits logstash_contrib {
  Exec {
  	path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin']
  }

  exec { 'logstash_contrib download':
    command => "wget -O ${staging_package} '${logstash_url}'",
    creates => "${staging_package}",
  } ~>


#tar -xzf /vagrant/files/source/logstash-contrib-1.4.0.tar.gz  --strip-components 2 logstash-contrib-1.4.0/lib/logstash

  exec { 'install logstash_contrib plugins':
    command => "tar -xzf ${staging_package} --strip-components 2 logstash-contrib-${logstash_version}/lib/logstash",
    cwd => "${plugin_dir}",
    creates => "${plugin_dir}/logstash/outputs/riak.rb",
    refreshonly => true
  } ~>

  exec { 'install logstash_contrib libs':
    command => "tar -xzf ${staging_package} --strip-components 1",
    cwd => "${logstash_dir}",
    creates => "${logstash_dir}/lib/logstash/outputs/riak.rb",
    refreshonly => true
  } ~>

  exec { 'fix logstash_contrib perms':
  	command => "find ${logstash_dir} -exec chown logstash:logstash {} \\;",
    refreshonly => true
  }

}