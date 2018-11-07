# graylog
#
# Configures a graylog server including modules for mongodb, elastic search, and others.
#
# @summary  This profile configures and setups the graylog for centralized log capture.  The server
#           not only aggregates logs, it uses mongo db for providing searchs and visualization.
#
# @param    none
#
# @example
#   include profile::graylog or assign in PE classifier
# == Class: profile::apps::graylog
class profile::apps::graylog (
){
  firewall { '300 allow graylog access':
    dport  => [9000],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '301 allow elasticsearch access':
    dport  => [9200],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '302 allow mongodb access':
    dport  => [27017],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '303 allow graylog syslog input':
    dport  => [5140],
    proto  => udp,
    action =>  accept,
  }

  class {'mongodb::globals':
    manage_package_repo => true,
  }
  -> class {'mongodb::client': }
  -> class {'mongodb::server': }

  -> class { 'elasticsearch':
  }
  -> elasticsearch::instance { 'graylog':
    config => {
      'cluster.name' => 'graylog',
      'network.host' => '127.0.0.1',
    }
  }

  class { 'java':
    distribution => 'jre',
  }
  -> class { 'graylog::repository':
    version => '2.4'
  }
  -> class { 'graylog::server':
    config => {
      'root_username'      => 'admin',
      'password_secret'    => '2FCsLlZ0Ch0PuAzq068=',
      'root_password_sha2' => '0f343519a67604a6db993b1fa23fc4734554f54c3ecd1899d257d683caff21d3',
      'web_enable'         => true,
      'web_listen_uri'     => "http://${facts['fqdn']}:9000",
      'rest_listen_uri'    => "http://${facts['fqdn']}:9000/api/",
      'rest_transport_uri' => "http://${facts['fqdn']}:9000/api/",
    }
  }
}
