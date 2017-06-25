# == Class: profile::unifi
class profile::unifi
{
  firewall { '200 allow unifi access':
    dport  => [80, 443, 8080, 8443, 8843, 8880, 3478, 6789, 10001],
    proto  => tcp,
    action =>  accept,
  }
}
