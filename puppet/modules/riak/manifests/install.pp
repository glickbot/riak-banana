class riak::install inherits riak {
	if $stage_package {
	  exec { 'riak download':
        command => "wget -O ${package_real_source} ${package_url}",
        creates => "${package_real_source}",
        path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin'],
        before => Package['riak']
  	  }
	}
	package {'riak':
		ensure => $package_ensure,
		name => $package_name,
		source => $package_real_source,
		provider => $package_real_provider,
	}
}