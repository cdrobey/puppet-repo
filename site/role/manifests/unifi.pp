# unifi
#
# Install and configure unifi application server
#
# @summary  This role delivers a unifi application server to manage Ubiquiti network devices.
#           Unifi provides a unified interface for management of firewall, waps, and switches.
#
# @param    none
#
# @example
#   include role::unifi or assign in PE classifier
# == Class: role::unifi
class role::unifi {
  include profile::base
  include profile::os::monitor
  include profile::apps::unifi
  include profile::apps::monitormaster
  include profile::os::monitor
}
