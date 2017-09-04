# == Class: profile::linux::security::fwpost
class profile::linux::security::fwpost {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
