# app
#
# Install and configure base app profile.
#
# @summary  This profile configures the yum/apt provider and installs a list of appliations.  Using 
#           parameters from hiera the list of packages is installed an performs a reboot when necessary.
#           Debian systems are configured for updates on a specific frequency.
#
# @param    update_frequency - number specifying the frequency of package updates
#           upgrade_frequency - number defining the upgrade frequency
#           packages - hashed list of packages install
#
# @example
#   include profile::linux::app or assign in PE classifier
# == Class: profile::linux::app
class profile::linux::app (
  $update_frequency,
  $upgrade_frequency,
  $packages,
) {

  if $facts['os']['family'] == 'Debian'{
    class { 'apt':
      update => {
        frequency => $update_frequency,
      },
    }
    class {'unattended_upgrades':
      period => '$upgrade_frequency',
    }
  }
  ensure_packages($packages, {'ensure' => 'present'})
}
