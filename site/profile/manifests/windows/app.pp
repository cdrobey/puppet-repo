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
  reboot { 'package_reboot':
    when => 'pending',
  }

  service { 'WinRM':
      ensure    => 'running',
      enable    => true,
      subscribe => Package['powershell']
  }

  package { 'dotnet4.5':
    notify => Reboot['package_reboot']
  }
  package { 'powershell':
    notify => [
      Reboot['package_reboot'],
      Service['WinRM'],
    ],
  }



  # Dynamic installed packages (Defined in Heira)
  each ($packages) | $package | {
    package { $package: }
  }
}
