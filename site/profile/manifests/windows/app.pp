# == Class: profile::windows::app
class profile::windows::app (
  $packages,
) {
  include chocolatey

  Package { provider => chocolatey, }

  #package { '7zip':
  #  ensure => present,
  #}
  each ($packages) | $name | {
    package { $name: }
      ensure => present,
    }
  }
}
