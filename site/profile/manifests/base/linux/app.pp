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
#   include profile::base::linux::app or assign in PE classifier
# == Class: profile::base::linux::app
class profile::base::linux::app (
  String $update_frequency,
  String $upgrade_frequency,
  Array $packages,
) {

  if $facts['os']['family'] == 'Debian'{
    class { 'apt':
      update => {
        'frequency' => $update_frequency,
      },
    }
    class { 'unattended_upgrades': }
  }
  ensure_packages($packages, {'ensure' => 'present'})
}
