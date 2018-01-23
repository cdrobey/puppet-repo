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
#   include profile::base::linux or assign in PE classifier
# == Class: profile::base::linux
class profile::base::linux {
  include 'profile::base::linux::accounts'
  include 'profile::base::linux::app'
  include 'profile::base::linux::security'
  include 'profile::base::linux::motd'
  include 'profile::base::linux::ssh'
  include 'profile::base::linux::sudoers'
  include 'profile::base::linux::time'

  firewall { '200 allow puppet agent access':
    dport  => [8140],
    proto  => tcp,
    action =>  accept,
  }
}
