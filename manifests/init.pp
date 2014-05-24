class kibana (
  $install_dir   = $apache::docroot,
  $logstash_host = '127.0.0.1',
  $logstash_port = '9200',
  $tarball       = 'kibana-3.1.0'
) {
  $source_url = "https://download.elasticsearch.org/kibana/kibana/${tarball}.tar.gz"
  Exec {
    path => $::path,
    cwd  => $install_dir,
  }
  exec { 'wget-kibana':
    command     => "wget --no-check-certificate $source_url",
    creates     => "${install_dir}/${tarball}.tar.gz",
    refreshonly => false,
    notify      => Exec['untar-kibana'],
  }
  exec { 'untar-kibana':
    command     => "tar zxpf ${tarball}.tar.gz --strip-components=1",
    creates     => "${install_dir}/index.html",
    refreshonly => true,
  }
  file { "${install_dir}/config.js":
    ensure  => file,
    owner   => 'root',
    group   => $::apache::params::root_group,
    mode    => '0644',
    content => template("${module_name}/config.js.erb"),
    require => Exec['untar-kibana'],
  }
}
