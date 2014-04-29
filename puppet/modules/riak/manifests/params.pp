class riak::params {
  $package_name = [ 'riak' ]
  $package_source = undef
  $package_ensure = undef
  $package_version = undef
  $package_provider = undef
  $package_url = undef
  $service_manage = true
  $service_name = 'riak'
  $service_ensure = 'running'
  $service_enable = true
  $riak_conf = {}

  case $::osfamily {
    'Debian': {
      if defined($package_url) {
        $stage_package = true
        $package_real_source = '/tmp/riak.deb'
        $package_real_provider = 'dpkg'
      } else {
        $package_real_provider = $package_provider
      }
    }
#TODO:
#      'RedHat': {
#         $stage_package = false
#         $package_real_source = $package_url
#         $package_real_provider = $package_provider
#      }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}