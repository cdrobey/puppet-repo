# == Class: profile::gitlab
class profile::gitlab {
  firewall { '80 allow apache access':
    dport  => [80],
    proto  => tcp,
    action => accept,
  }
  class {'::gitlab':}
}
