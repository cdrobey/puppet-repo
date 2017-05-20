# == Class: profile::base::time
class profile::base::time {
  class { '::ntp':
    package_ensure => 'present',
  }
  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/US/Central',
  }
}
