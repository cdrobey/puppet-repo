# == Class: profile::master
class profile::master
{
  firewall { '200 allow puppet access':
    dport  => [80, 443, 8140, 8142, 61613],
    proto  => tcp,
    action =>  accept,
  }
}
