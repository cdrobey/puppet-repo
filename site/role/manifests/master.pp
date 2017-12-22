# master
#
# Install and configure PE Master server
#
# @summary  This role delivers a PE Master server to perform management across a set of puppet managed clients.
#           The role applies the baseline configuration to the puppet master and opens all ports needed for a
#           monolithic Puppet install.
#
# @param    none
#
# @example
#   include role::master or assign in PE classifier
# == Class: role::master
class role::master {
  include 'profile::base'
  include 'profile::apps::master'
}
