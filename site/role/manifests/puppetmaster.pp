# puppetmaster
#
# Install and configure PE puppetmaster server
#
# @summary  This role delivers a PE puppetmaster server to perform management across a set of puppet managed clients.
#           The role applies the baseline configuration to the puppet puppetmaster and opens all ports needed for a
#           monolithic Puppet install.
#
# @param    none
#
# @example
#   include role::puppetmaster or assign in PE classifier
# == Class: role::puppetmaster
class role::puppetmaster {
  include profile::base
  include profile::os::monitor
  include profile::apps::puppetmaster
}
