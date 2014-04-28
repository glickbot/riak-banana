class riak (
  $package_name = $riak::params::package_name,
  $package_source = $riak::params::package_source,
  $package_url = $riak::params::package_url,
  $package_ensure = $riak::params::package_ensure,
  $package_version = $riak::params::package_version,
  $package_provider = $riak::params::package_provider,
  $service_manage = $riak::params::service_manage,
  $service_name = $riak::params::service_name,
  $service_ensure = $riak::params::service_ensure,
  $service_enable = $riak::params::service_enable,
  $riak_conf = $riak::params::riak_conf,
    

) inherits riak::params {

    anchor { 'riak::begin': } ->
    class { '::riak::install': } ->
    class { '::riak::config': } ~>
    class { '::riak::service': } ->
    anchor { 'riak::end': }
}
