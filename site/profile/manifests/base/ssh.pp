# == Class: profile::base::ssh
class profile::base::ssh {
  include ssh

  firewall { '100 allow ssh access':
    dport  => '22',
    proto  => tcp,
    action => accept,
  }
}
