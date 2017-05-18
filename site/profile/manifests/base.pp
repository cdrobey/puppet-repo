class profile::base {

  #the base profile should include component modules that will be on all nodes

  class profile::base::time {
    include ::ntp
    file { '/etc/localtime':
      ensure => link,
      target => '/usr/share/zoneinfo/US/Central',
    }
  }
}
