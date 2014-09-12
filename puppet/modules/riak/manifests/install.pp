class riak::install inherits riak {

  if defined('$package_source') {
    # If $package_source is defined, the file is local, don't download
    # install with dpkg from file location
    $stage_package = false
    $package_real_source = $package_source
  } elsif defined('$package_url') {
    # If url is defined, download to staging area, then use dpkg to install
    $stage_package = true
    $package_real_source = "$package_temp_dir/riak.$package_type"
  } else {
    # otherwise, use default ( undef, or user configured )
    $stage_package = false
    if $repo_manage == true {
      class { 'packagecloud': }
      packagecloud::repo { "basho/riak":
          type => $package_type,
          notify => Exec['update basho_riak']
      }
    }
    if !defined('$package_ensure') and defined('$package_version') {
      $package_ensure = $package_version
    }
  }

	if $stage_package {
	  exec { 'riak download':
        command => "wget -O ${package_real_source} ${package_url}",
        creates => "${package_real_source}",
        path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin'],
        before => Package['riak'],
				timeout => 0, #for carrier pigeon interwebs
  	  }
	}

  exec { 'update basho_riak':
    command => 'apt-get update',
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin/'],
    refreshonly => true,
    before => Package['riak']
  }

  if defined($package_real_source) {
    package {'riak':
      name => $package_name,
      ensure => $package_ensure,
      source => $package_real_source,
      provider => $package_provider
    }
  } else {
    package {'riak':
      ensure => $package_ensure,
      name => $package_name,
      provider => $package_provider
    }
  }
}
