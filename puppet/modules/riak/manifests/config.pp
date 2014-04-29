class riak::config inherits riak {


  group { 'riak':
    ensure => present,
    system => true,
  }
  user { 'riak':
    ensure  => present,
    system  => true,
    home    => '/var/lib/riak',
    require  => [
      Group['riak']
    ]
  }

  limits::fragment {
    "*/soft/nofile":
      value => "65535";
    "*/hard/nofile":
      value => "65535";
  }

  file_line { 'pam-limits':
    path => '/etc/pam.d/common-session',
    line => 'session required pam_limits.so'
  }

  define param(
    $value = false,
    $config = '/etc/riak/riak.conf',
    $ensure = present
  ){
  	ini_setting { $name:
      ensure => $ensure,
      path => $config,
      section => '',
      setting => $name,
      value => $value
  	}
  }

  create_resources( riak::config::param, $riak_conf )
}