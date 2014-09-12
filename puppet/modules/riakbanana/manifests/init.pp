class riakbanana (

		$riak_host = $riakbanana::params::riak_host,
		$riak_port = $riakbanana::params::riak_port

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
