# == Class: profile::base::time
class profile::base::time (
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
