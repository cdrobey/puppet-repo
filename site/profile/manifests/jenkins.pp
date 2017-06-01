# == Class: profile::jenkins
class profile::jenkins {
  firewall { '8080 allow jenkins access':
    dport  => [8080],
    proto  => tcp,
    action => accept,
  }
  class {'::jenkins':}
}
