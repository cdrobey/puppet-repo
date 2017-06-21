# == Class: profile::base::ssh
class profile::base::ssh (
  $password_authentication,
  $permit_root_login,
  $permit_empty_passwords,
  $manage_firewall,
) {


  class { 'ssh::server':
    options => {
      sshd_password_authentication     => $password_authentication,
      permit_root_login                => $permit_root_login,
      sshd_config_permitemptypasswords => $permit_empty_passwords,
      manage_firewall                   => $manage_firewall,


    }
  }
}
