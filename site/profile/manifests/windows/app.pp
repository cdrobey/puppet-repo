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
  package { 'dotnet4.5':
    notify => Reboot['package_reboot']
  }
  package { 'powershell':
    notify => Reboot['package_reboot']
  }
  # Dynamic installed packages (Defined in Heira)
  each ($packages) | $package | {
    package { $package: }
  }
}
