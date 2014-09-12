class profile::rihanna::server inherits profile::base {

	stage { "pre":
		before => Stage["riak"]
	}
	stage { "riak":
		before => Stage["riakbanana"]
	}
	stage { "riakbanana":
	}

  class { '::oracle_java':
		stage => pre
	}

  class { '::riak':
		stage => riak
  }

  class { '::riakbanana':
		stage => riakbanana
	}

}
