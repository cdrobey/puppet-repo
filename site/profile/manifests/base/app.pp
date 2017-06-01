# == Class: profile::base::apt
class profile::base::app {

  # Hiera lookups
  $app_update_frequency = hiera('profile::base::app::update_frequency')
  $app_packages = hiera_array('profile::base::app::packages')

  if $::os['family'] == 'Ubuntu'{
    class { '::apt':
      update => {
      frequency => app_update_frequency,
      },
    }
  }
  ensure_packages($app_packages, {'ensure' => 'present'})
}
