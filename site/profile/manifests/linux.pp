# == Class: profile::linux
class profile::linux {
  include 'profile::linux::accounts'
  include 'profile::linux::app'
  include 'profile::linux::fw'
  include 'profile::linux::motd'
  include 'profile::linux::ssh'
  include 'profile::linux::sudoers'
  include 'profile::linux::time'
}
