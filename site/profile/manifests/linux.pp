# linux
#
# Install and configure base linux profile.
#
# @summary  This profiles aggregates all profiles needed for a baseline security configuration
#           of a linux server or desktop.
#
# @param    none
#
# @example
#   include profile::linux or assign in PE classifier
# == Class: profile::linux
class profile::linux {
  include 'profile::linux::accounts'
  include 'profile::linux::app'
  include 'profile::linux::security'
  include 'profile::linux::motd'
  include 'profile::linux::ssh'
  include 'profile::linux::sudoers'
  include 'profile::linux::time'

  firewall { '200 allow puppet agent access':
    dport  => [8140],
    proto  => tcp,
    action =>  accept,
  }
}
