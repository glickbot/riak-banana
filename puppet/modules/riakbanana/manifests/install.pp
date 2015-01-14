class riakbanana::install inherits riakbanana {

# logstash's riak output doesn't currently understand bucket types, so we'll
#    install them directly via bucket properties

### Banana

  package { 'git':
    ensure => installed
  } ->
  exec { 'install banana':
    command => "git clone https://github.com/LucidWorks/banana.git",
    cwd => "${banana_install_dir}",
    creates => "${banana_install_dir}/banana",
  } ->
  file { 'banana dashboard':
    path => "${banana_install_dir}/banana/src/app/dashboards/default.json",
    content => template("riakbanana/dashboard.json.erb"),
    ensure => present
  }

### Nginx

  package { 'nginx':
    ensure => installed
  } ->
  file { 'nginx config':
    path => "/etc/nginx/sites-available/default",
    content => template("riakbanana/nginx.conf.erb"),
    ensure => present
  } ~>
  service { 'nginx':
    ensure => running,
  }

### Riak Solr Schema & Bucket

  exec { 'install schema':
    command => "curl -XPUT '${riak_url}/search/schema/${index}' -H 'content-type: application/xml' --data-binary @/vagrant/files/logstash_logs.xml",
    unless => "curl '${riak_url}/search/schema/${index}' -f > /dev/null 2>&1",
  } ->
  exec { 'install index':
    command => "curl -XPUT '${riak_url}/search/index/${index}' -H 'content-type: application/json' -d '{\"schema\":\"${index}\"}'",
    unless => "curl -s '${riak_url}/search/index/${index}' -f > /dev/null 2>&1",
  } ->
  exec { 'wait_for_index':
    command => "curl -f '${riak_url}/search/schema/${index}' > /dev/null 2>&1",
    tries => 20,
    try_sleep => 5,
  } ->
  exec { 'configure bucket':
    command => "curl -H 'content-type: application/json' -XPUT '${riak_url}/buckets/${index}/props' -d '{\"props\":{\"search_index\":\"${index}\"}}'",
    unless => "curl -s '${riak_url}/buckets/${index}/props' | grep '\"search_index\":\"${index}\"' > /dev/null 2>&1",
    require => Exec['install index']
  }

}
