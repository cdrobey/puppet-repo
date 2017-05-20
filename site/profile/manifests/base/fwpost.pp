# == Class: profile::base::fwpost
class profile::base::fwpost {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
