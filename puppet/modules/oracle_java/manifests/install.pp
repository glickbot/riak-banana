class oracle_java::install inherits oracle_java {
  Exec {
  	path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin']
  }

  file { 'jvm directory':
    path => "${jvm_dir}",
    ensure => directory,
  }

  exec { 'java download':
    command => "wget -O ${staging_package} --no-cookies --no-check-certificate --header 'Cookie: ${accept_cookie}' '${download_url}'",
    creates => "${staging_package}",
    path => ['/usr/local/bin','/usr/bin', '/bin','/usr/local/sbin','/usr/sbin','/sbin'],
    timeout => 0, #for the carrier pidgeon webs
  } ~>

  exec { 'extract java':
    command => "tar -xzf ${staging_package}",
    cwd => "${jvm_dir}",
    creates => "${jvm_dir}/${java_version}",
    require => [File['jvm directory']]
  } ~>

  exec { 'fix perms':
  	command => "find ${jvm_dir} -exec chown root:root {} \\;",
    refreshonly => true
  } ~>

  exec { 'update alternatives':
    command => "update-alternatives --install /usr/bin/java java ${jvm_dir}/${java_version}/bin/java 0",
    refreshonly => true
  }
}
