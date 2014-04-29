class logstash_contrib::params {
	$logstash_version = '1.4.0'
	$url_base = 'http://download.elasticsearch.org/logstash/logstash'
	$logstash_dir = '/opt/logstash'
	$staging_package = '/tmp/logstash-contrib-${logstash_version}.tar.gz'
	$logstash_url = "${url_base}/logstash-contrib-${logstash_version}.tar.gz"
	$plugin_dir = '/etc/logstash/plugins'
}