# app
#
# Install and configure base app profile.
#
# @summary  This profile configures the chocolatey provider and installs a list of appliations.  Using 
#           parameters from hiera the list of packages is installed an performs a reboot when necessary.
#           A standard set of fixed packages including dotnet 4.5 and powershell are updated to ensure 
#           chocolatey support.
#
# @param    packages - hashed list of packages install
#
# @example
#   include profile::base::windows::app or assign in PE classifier
# == Class: profile::base::windows::app
class profile::base::windows::app (
  Array $packages,
) {
  include chocolatey

  Package {
    ensure => installed,
    provider => chocolatey,
  }
  schedule { 'package_schedule':
    range   => '02:00 - 04:00',
    weekday => 'Monday',
  }
  reboot { 'package_reboot':
    when     => 'pending',
    schedule => 'package_schedule'
  }
  package { 'dotnet4.5':
    notify => Reboot['package_reboot']
  }
  package { 'powershell':
    notify => Reboot['package_reboot']
  }
  service { 'WinRM':
    ensure => 'running',
    enable => true,
  }
  # Dynamic installed packages (Defined in Heira)
  each ($packages) | $package | {
    package { $package:
      notify => Reboot['package_reboot']
    }
  }
}
