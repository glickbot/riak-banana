class riakbanana::params {
	$index = logstash_logs
	$riak_host = localhost
	$riak_port = 8098
	$solr_webapp_dir = "/usr/lib/riak/lib/yokozuna-2.0.0beta1-68-g0f0fc47/priv/solr/solr-webapp/webapp"
	$riak_url = "http://${riak_host}:${riak_port}"

}
