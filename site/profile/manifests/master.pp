# == Class: profile::master
class profile::master {
  firewall { '200 allow puppet access':
    dport  => [8140, 443, 61613, 8142, 4433],
    proto  => tcp,
    action =>  accept,
  }
  include 'profile::master::nodemanager'
}
