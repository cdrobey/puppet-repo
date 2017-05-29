# == Class: profile::base::apt
class profile::base::app {

  if $::os['family'] == 'Ubuntu'{
    class { '::apt':
      update => {
      frequency           => 'daily',
      },
    }
  }
  ensure_packages(hiera_array('base_apps'), {'ensure' => 'present'})
}
