# == Class: profile::base
class profile::coderepo {
  
  firewall { '80 allow apache access':
    dport          => [80],
    proto      => tcp,
    action => accept,
  }
  class {'::gitlab':}
}
