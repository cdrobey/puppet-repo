# == Class: profile::linux::time
class profile::linux::time (
  $timezone,
  $ntp_servers,
) {

  class { 'ntp':
    package_ensure => 'present',
    servers        => $ntp_servers,
  }

  file { '/etc/localtime':
    ensure => link,
    target => $timezone,
  }
}
