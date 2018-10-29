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
class {'mongodb::globals':
  manage_package_repo => true,
}
-> class {'mongodb::client': }
-> class {'mongodb::server': }

  class { 'java':
    distribution => 'jre',
  }
  -> class { 'elasticsearch':
    version     => 5,
    manage_repo => true,
  }
  -> elasticsearch::instance { 'graylog':
    config => {
      'cluster.name' => 'graylog',
      'network.host' => '127.0.0.1',
    }
  }

  class { 'graylog::repository':
    version => '2.4.6'
  }
  -> class { 'graylog::server':
    config          => {
      'password_secret'    => 'mOP51XcWO1TQ8ajtz2k=',
      'root_password_sha2' => '69fef8305e2165a3427f19a6fc09786beaa943dee3b460e68d4e1a61c6bce25d  -',
    }
  }
}
