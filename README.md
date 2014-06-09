# puppet-kibana

A Puppet module for managing Kibana.

## Usage Examples

Default configuration where Kibana runs on the Logstash host.

    include kibana

NOTE: This requires the fork of nanliu-staging available at:

https://github.com/mhaskel/puppet-staging/tree/strip

## Kibana parameters

* `install_dir`<br />
The web root directory in which to install Kibana.  Default: `$apache::docroot`

* `logstash_host`<br />
The hostname or IP address of the Logstash daemon.  Default: `$logstash_reporter::logstash_host`

* `logstash_port`<br />
The port of the Logstash daemon.  Default: `$logstash_reporter::logstash_port`

* `tarball`<br />
The tarball to be downloaded as https://download.elasticsearch.org/kibana/kibana/${tarball}.tar.gz to specify version of Kibana.  Default `kibana-3.1.0`
