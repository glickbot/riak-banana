class oracle_java (
	$version = $oracle_java::params::version,
	$download_url = $oracle_java::params::download_url,
	$staging_package = $oracle_java::params::staging_package,
	$java_version = $oracle_java::params::java_version,
	$jvm_dir = $oracle_java::params::jvm_dir

	) inherits oracle_java::params {

		anchor { 'oracle_java::begin': } ->
		class { '::oracle_java::install': } ->
		anchor { 'oracle_java::end': }

}