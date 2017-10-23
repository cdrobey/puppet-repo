# == Class: profile::linux
class profile::linux {
  include 'profile::linux::accounts'
  include 'profile::linux::app'
  include 'profile::linux::security'
  include 'profile::linux::motd'
  include 'profile::linux::ssh'
  include 'profile::linux::sudoers'
  include 'profile::linux::time'

  firewall { '200 allow unifi access':
    dport  => [8140],
    proto  => tcp,
    action =>  accept,
  }
}
