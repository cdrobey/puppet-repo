# == Class: profile::base::time
class profile::base::time {

  $time_tz = hiera('profile::base::time')
  $time_ntp_servers = hiera_array('profile::base::ntpservers')

  class { 'ntp':
    package_ensure => 'present',
    servers        => $time_ntp_servers,
  }

  file { '/etc/localtime':
    ensure => link,
    target => $time_tz,
  }
}
