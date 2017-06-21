# == Class: profile::base::apt
class profile::base::app (
  $update_frequency,
  $packages,
) {

  if $facts['os']['family'] == 'Debian'{
    class { 'apt':
      update => {
        frequency => $update_frequency,
      },
    }
  }
  ensure_packages($packages, {'ensure' => 'present'})
}
