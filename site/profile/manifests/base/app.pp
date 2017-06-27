# == Class: profile::base::apt
class profile::base::app (
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
