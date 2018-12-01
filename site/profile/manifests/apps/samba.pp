# samba
#
# Install and configure samba file server profile.
#
# @summary  This profiles uses the several modules to configure an installation of a file server.  The module loads the application from the primary ubiquiti application reposibioties.
# 
#
# @param    none
#
# @example
#   include profile::apps::samba or assign in PE classifier
# == Class: profile::apps::samba
class profile::apps::samba (
  String $ldap_user,
  String $ldap_password,
){

  firewall { '300 allow tcp communication to smbd/nbmd':
    dport  => [137, 138, 139, 445],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '301 allow udp communication to smbd/nbmd':
    dport  => [137, 138, 139, 445],
    proto  => udp,
    action =>  accept,
  }

  class { 'samba::classic':
    domain             => 'LOCAL',
    realm              => 'local.familyroberson.com',
    smbname            => 'NAS',
    adminuser          => 'administrator',
    adminpassword      => 'c0mPL3xe_P455woRd',
    sambaloglevel      => 1,
    join_domain        => false,
    logtosyslog        => true,
    sambaclassloglevel => {
      'smb'     => 2,
      'idmap'   => 2,
      'winbind' => 2,
    },
    globaloptions      => {
      'winbind cache time' => 10,
    },
  }

  samba::idmap { 'Domain DC':
    domain       => '*',
    idrangemin   => 10000,
    idrangemax   => 19999,
    backend      => 'ldap',
    ldap_base_dn => 'o=5aeb5ceb0522cc3e85b134bc,dc=jumpcloud,dc=com',
    ldap_user_dn => $ldap_user,
    ldap_passwd  => $ldap_password,
    ldap_url     => 'ldap://ldap.jumpcloud.com',
  }
}
