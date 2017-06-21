# == Class: profile::base::ssh
class profile::base::ssh (
  $passwordauth,
  $permitrootlogin,
) {

  firewall { '100 allow ssh access':
      dport  => '22',
      proto  => tcp,
      action => accept,
  }

  class { 'ssh': }

  class { 'ssh::server':
    options => {
      'PasswordAuthentication' => $passwordauth,
      'PermitRootLogin'        => $permitrootlogin,
    },
  }
}
