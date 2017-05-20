# == Class: profile::base::apt
class profile::base::apt {
  class { '::apt':
    update => {
      frequency           => 'daily',
    },
  }
}
