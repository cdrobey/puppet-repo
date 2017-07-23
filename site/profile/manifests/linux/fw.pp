# == Class: profile::linux::fw
class profile::linux::fw {

  class { 'firewall': }
  class { 'profile::linux::fwpre': }
  class { 'profile::linux::fwpost': }

  Firewall {
    before  => Class['profile::linux::fwpost'],
    require => Class['profile::linux::fwpre'],
  }
  resources { 'firewall':
    purge => true,
  }
}
