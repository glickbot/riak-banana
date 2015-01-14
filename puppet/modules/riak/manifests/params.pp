class riak::params {

  $package_source = undef
  $package_url = undef
  $package_version = '2.0.4-1'
  $repo_manage = true
  $service_manage = false
  $service_enable = true
  $service_ensure = 'running'
  $riak_conf = {}
  $service_name = 'riak'
  $package_provider = undef
  $package_temp_dir = "/tmp"
  $package_ensure = undef
  $package_name = [ 'riak' ]
  $ulimit = 65536

  case $::osfamily {
   'Debian': {
      $package_type = "deb"
    }
    'RedHat': {
      $package_type = "rpm"
    }
    default: {
      fail("This ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
