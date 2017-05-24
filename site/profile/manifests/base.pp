# == Class: profile::base
class profile::base {
  include 'profile::base::accounts'

  if $::os['family'] == 'Ubuntu'{
    include 'profile::base::apt'
  }
  include 'profile::base::motd'
  include 'profile::base::ssh'
  include 'profile::base::sudoers'
  include 'profile::base::time'
  include 'profile::base::fw'
}
