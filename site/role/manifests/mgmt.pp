# management
#
# Install and configure management application server
#
# @summary  This role delivers a management application server to manage systems services.  The role
#           builds a unifi network management station and grafana/influxdb/telegraf measurement
#           system.
#
# @param    none
#
# @example
#   include role::mgmt or assign in PE classifier
# == Class: role::mgmt
class role::mgmt {
  include profile::base
  include profile::os::monitor
  include profile::apps::haproxy
  include profile::apps::unifi
  include profile::apps::monitormaster
}
