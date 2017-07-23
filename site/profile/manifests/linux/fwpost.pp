# == Class: profile::linux::fwpost
class profile::linux::fwpost {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
