class riakbanana::params {
	$index = logstash_logs
	$riak_host = localhost
	$riak_port = 8098
	$riak_url = "http://${riak_host}:${riak_port}"
	$banana_install_dir = "/opt"
	$banana_host = '127.0.0.1'
	$banana_port = 80
	$solr_port = 8093
}
