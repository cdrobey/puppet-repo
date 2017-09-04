# == Class: profile::print
class profile::print {

  firewall { '200 allow tcp printer access':
    dport  => [80, 443, 631, 515, 5353],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '200 allow udp printer access':
    dport  => [631, 515, 5353],
    proto  => udp,
    action =>  accept,
  }

}
