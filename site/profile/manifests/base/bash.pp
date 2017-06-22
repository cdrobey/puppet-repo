#
class profile::base::bash {
  include bash

  bash::setup{ '/home/deploy':
      ensure => 'present',
      user   => 'deploy',
      group  => 'deploy',
  }
}
