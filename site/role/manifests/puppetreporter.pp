# puppetreporter
#
# Install and configure PE monitoring server
#
# @summary  This module build a monitoring plaform using InfluxDB and Grafana.  It uses the
#           Puppet Report modules to keep statistics and build dashboards for PE.
#
# @param    none
#
# @example
#   include role::puppetreporter or assign in PE classifier
# == Class: role::puppetreporter
class role::puppetreporter {
  include profile::base
  include profile::apps::puppetreporter
}
