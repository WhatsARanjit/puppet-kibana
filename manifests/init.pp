class kibana (
  $install_dir   = $apache::docroot,
  $logstash_host = $::ipaddress,
  $logstash_port = '9200',
  $tarball       = 'kibana-3.1.0',
  $staging_dir   = '/var/staging',
  $staging_owner = 'pe-puppet',
  $staging_group = 'pe-puppet'
) {
  $source_url = "https://download.elasticsearch.org/kibana/kibana/${tarball}.tar.gz"
  Exec {
    path => $::path,
    cwd  => $install_dir,
  }
  class { 'staging':
    path  => $staging_dir,
    owner => $staging_owner,
    group => $staging_group,
  }
  staging::file { "${tarball}.tar.gz":
    source => $source_url,
  }
  staging::extract { "${tarball}.tar.gz":
    target  => $install_dir,
    strip   => '1',
    creates => "${install_dir}/${tarball}",
    require => Staging::File["${tarball}.tar.gz"],
  }
  file { "${install_dir}/config.js":
    ensure  => file,
    owner   => 'root',
    group   => $::apache::params::root_group,
    mode    => '0644',
    content => template("${module_name}/config.js.erb"),
    require => Staging::Extract["${tarball}.tar.gz"]
  }
}
