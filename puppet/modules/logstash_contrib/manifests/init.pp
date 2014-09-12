class logstash_contrib (
		$logstash_version = $logstash_contrib::params::logstash_version,
		$url_base = $logstash_contrib::params::url_base,
		$logstash_dir = $logstash_contrib::params::logstash_dir,
		$staging_package = $logstash_contrib::params::staging_package,
		$logstash_url = $logstash_contrib::params::logstash_url,
		$plugin_dir = $logstash_contrib::params::plugin_dir
	) inherits logstash_contrib::params {

	anchor { 'logstash_contrib::begin': } ->
	class { '::logstash_contrib::install': } ->
	anchor { 'logstash_contrib::end': }
}
