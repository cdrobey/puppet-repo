# == Class: profile::base::ssh
class profile::base::ssh {

  $server_options_passwordauth = hiera('profile::base::ssh::server_options::passwordauth')
  $server_options_permitrootlogin = hiera('profile::base::ssh::server_options::permitrootlogin')

  firewall { '100 allow ssh access':
      dport  => '22',
      proto  => tcp,
      action => accept,
  }

  class { 'ssh::server_options':
    PasswordAuthentication => $server_options_passwordauth,
    PermitRootLogin        => $server_options_permitrootlogin,
  }
}
