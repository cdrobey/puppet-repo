# == Class: profile::linux::apt
class profile::linux::app (
  $update_frequency,
  $upgrade_frequency,
  $packages,
) {

  if $facts['os']['family'] == 'Debian'{
    class { 'apt':
      update => {
        frequency => $update_frequency
        ensure = present,
      },
    }
    class {'unattended_upgrades':
      period => '$upgrade_frequency',
    }
  }
  ensure_packages($packages, {'ensure' => 'present'})
}
