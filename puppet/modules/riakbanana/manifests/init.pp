class riakbanana (
		$index = $riakbanana::params::index,
		$riak_host = $riakbanana::params::riak_host,
		$riak_port = $riakbanana::params::riak_port,
		$riak_url = $riakbanana::params::riak_url,
		$banana_install_dir = $riakbanana::params::banana_install_dir,
		$banana_host = $riakbanana::params::banana_host,
		$banana_port = $riakbanana::params::banana_port,
		$solr_port = $riakbanana::params::solr_port
	) inherits riakbanana::params {


	Exec {
		path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin']
	}

	anchor { 'riakbanana::begin': } ->
	class { '::riakbanana::install':
		require => Service['riak']
	} ->
	class { '::riakbanana::config': } ->
	anchor { 'riakbanana::end': }
}
