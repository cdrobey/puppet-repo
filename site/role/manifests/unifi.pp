# unifi
#
# Install and configure a unifi management server
#
# @summary  This role delivers a unifi server to manage network services.  The role
#           builds a unifi network management platform to manage ubiquiti router, switches
#           and waps.
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
}
