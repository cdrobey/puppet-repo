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
}
