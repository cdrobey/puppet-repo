# == Class: profile::base::time
class profile::base::time {

  $time_tz = hiera('profile::base::time')

  class { 'ntp':
    package_ensure => 'present',
  }

  file { '/etc/localtime':
    ensure => link,
    target => $time_tz,
  }
}
