# == Class: profile::base::ssh
class profile::base::ssh {

  $ssh_server_options = hiera_array($profile::base::ssh::server_options)

  firewall { '100 allow ssh access':
      dport  => '22',
      proto  => tcp,
      action => accept,
  }

  class { 'ssh':
    server_options => $ssh_server_options,
  }
}
