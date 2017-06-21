# == Class: profile::base::time
class profile::base::time (
  $time_tz,
  $time_ntp_servers,
) {

  class { 'ntp':
    package_ensure => 'present',
    servers        => $time_ntp_servers,
  }

  file { '/etc/localtime':
    ensure => link,
    target => $time_tz,
  }
}
