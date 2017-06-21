#
class profile::base::bash {
  class { 'bash':
    ensure => 'present'
  }
}
