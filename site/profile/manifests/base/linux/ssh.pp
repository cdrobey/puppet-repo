# ssh
#
# Install and configure base ssh profile.
#
# @summary  This profile configures the ssh and sshd process.  Using parameters from hiera
#           the modules hardens access to sshd.
#
# @param    password_authentication - boolean used enable/disable ssh password access
#           permit_root_login - boolean used to enable/disable root access via ssh
#           permit_empty_password = boolean used to enable/disable access to ssh from account without a password
#           manage_firewall = boolean used to enable/disable ssh port 22
#           banner = boolean used to enable/disable the display of the motd after ssh login
#
# @example
#   include profile::base::linux::ssh or assign in PE classifier
# == Class: profile::base::linux::ssh
class profile::base::linux::ssh (
  String $password_authentication,
  String $permit_root_login,
  String $banner,
) {

  firewall { '201 allow ssh access':
    dport  => [22],
    proto  => tcp,
    action =>  accept,
  }

  class { 'ssh':
    sshd_password_authentication => $password_authentication,
    permit_root_login            => $permit_root_login,
    sshd_config_banner           => $banner,
  }
}
