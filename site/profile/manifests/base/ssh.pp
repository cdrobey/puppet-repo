# == Class: profile::base::ssh
class profile::base::ssh {
  class { 'ssh::server':
    storeconfigs_enabled => true
  }
}
