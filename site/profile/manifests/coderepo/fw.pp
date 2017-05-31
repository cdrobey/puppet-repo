# == Class: profile::coderepo::fw
class profile::coderepo::fw {
  include firewall
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
