class riak::service inherits riak {

if $service_manage == true {
		service { 'riak':
			ensure => $service_ensure,
			enable => $service_enable,
			name => $service_name,
			hasstatus => true,
			hasrestart => true
		}
	}
}
