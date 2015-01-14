class riakbanana::params {
	$index = logstash_logs
	$riak_host = localhost
	$riak_port = 8098
	$solr_webapp_dir = "/usr/lib/riak/lib/yokozuna-2.0.0-24-g1e4dba8/priv/solr/solr-webapp/webapp"
	$riak_url = "http://${riak_host}:${riak_port}"

}
