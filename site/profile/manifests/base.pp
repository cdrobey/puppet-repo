# == Class: profile::base
class profile::base {
  include 'profile::base::accounts'
  include 'profile::base::app'
  include 'profile::base::fw'
  include 'profile::base::motd'
  include 'profile::base::ssh'
  include 'profile::base::sudoers'
  include 'profile::base::time'
}
