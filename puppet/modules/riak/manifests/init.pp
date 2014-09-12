class riak (
  $package_source = $riak::params::package_source,
  $package_url = $riak::params::package_url,
  $package_version = $riak::params::package_version,
  $service_manage = $riak::params::service_manage,
  $repo_manage = $riak::params::repo_manage,

  $package_ensure = $riak::params::package_ensure,
  $package_name = $riak::params::package_name,
  $package_provider = $riak::params::package_provider,
  $service_name = $riak::params::service_name,
  $service_ensure = $riak::params::service_ensure,
  $service_enable = $riak::params::service_enable,
  $riak_conf = $riak::params::riak_conf,
  $package_temp_dir = $riak::params::package_temp_dir,
  $package_temp_name = $riak::params::package_temp_name,
  $ulimit = $riak::params::ulimit

) inherits riak::params {

	require oracle_java

    anchor { 'riak::begin': } ->
    class { '::riak::install': } ->
    class { '::riak::config': } ~>
    class { '::riak::service': } ->
    anchor { 'riak::end': }
}
