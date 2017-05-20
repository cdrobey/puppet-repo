# == Class: profile::base::ssh
class profile::base::ssh {
  class { '::ssh':
    permit_root_login => 'yes',
  }
}
