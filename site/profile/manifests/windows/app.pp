# == Class: profile::windows::app
class profile::windows::app (
  $packages,
) {
  include chocolatey

  Package {
    ensure => latest,
    provider => chocolatey,
  }

  # Static packages with Reboot
  reboot { 'dsc_reboot':
    when => 'pending',
  }
  package { 'dotnet4.5':
    notify => Reboot['dsc_reboot']
  }
  package { 'powershell':
    notify => Reboot['dsc_reboot']
  }
  package { 'powershell':
    notify => Reboot['dsc_reboot']
  }

  # Dynamic installed packages
  each ($packages) | $package | {
    package { $package: }
  }
}
