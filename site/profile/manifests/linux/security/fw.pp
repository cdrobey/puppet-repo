# == Class: rofile::linux::security::fw
class profile::linux::security::fw {

  class { 'firewall': }
  class { 'profile::linux::security::fwpre': }
  class { 'profile::linux::security::fwpost': }

  Firewall {
    before  => Class['profile::linux::security::fwpost'],
    require => Class['profile::linux::security::fwpre'],
  }
  resources { 'firewall':
    purge => true,
  }
}
