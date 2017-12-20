# apache
#
# Install and configure apache application server
#
# @summary  This role delivers a apache application server to manage Ubiquiti network devices.
#           apache provides a apacheed interface for management of firewall, waps, and switches.
#
# @param    none
#
# @example
#   include role::apache or assign in PE classifier
# == Class: role::apache
class role::apache {
  include profile::linux
  include profile::apache
}
