# == Class: profile::base::fw
class profile::base::fw {

  class { 'firewall:' },
  class { 'profile::base::fwpre:' },
  class { 'profile::base::fwpost:' },

  Firewall {
    before  => Class['profile::base::fwpost'],
    require => Class['profile::base::fwpre'],
  }
  resources { 'firewall':
    purge => true,
  }
}
