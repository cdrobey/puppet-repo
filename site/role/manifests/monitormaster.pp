# monitormaster
#
# Install and configure monitor management  server
#
# @summary  This role delivers a monitor application server to monitor systems services.  The role
#           builds a monitor station based upon grafana/influxdb/telegraf.
#
# @param    none
#
# @example
#   include role::monitormaster or assign in PE classifier
# == Class: role::monitormaster
class role::monitormaster {
  include profile::base
  include profile::os::monitor
  include profile::apps::monitormaster
  include profile::apps::ups
}
