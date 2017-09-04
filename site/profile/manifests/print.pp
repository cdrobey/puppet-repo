# == Class: profile::print
class profile::print {

  firewall { '200 allow unifi access':
    dport  => [80, 443, 631, 515],
    proto  => tcp,
    action =>  accept,
  }

}
