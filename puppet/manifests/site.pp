node default {
	
	host { 'localhost':
	  name => "${::fqdn}",
	  #aliases => ["${::hostname}", "localhost"],
	  ip => "127.0.0.1"
	}

    include role::default
}
