# == Class: profile::base::fw
class profile::base::fw {

  clas { 'firewall:'}
  include 'profile::base::fwpre'
  include 'profile::base::fwpost'
  Firewall {
    before  => Class['profile::base::fwpost'],
    require => Class['profile::base::fwpre'],
  }
  resources { 'firewall':
    purge => true,
  }
}
