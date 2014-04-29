class riakbanana::install inherits riakbanana {


  exec { 'install index':
    command => "curl -XPUT -i '${riak_url}/search/index/${index}'",
    unless => "curl '${riak_url}/search/index/${index}' -f",
    notify => Exec['create bucket-type']
  }

  exec { 'create bucket-type':
	command => "riak-admin bucket-type create data '{\"props\":{}}'",
	notify => Exec['activate bucket-type']
  }

  exec { 'activate bucket-type':
    command => "riak-admin bucket-type activate data",
    notify => Exec['configure bucket']
  }

  exec { 'configure bucket': 
    command => "curl -i -H 'content-type: application/json' -X PUT '${riak_url}/types/data/buckets/${index}/props' -d '{\"props\":{\"search_index\":\"${index}\"}}'"
  }
}