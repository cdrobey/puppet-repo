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
    domain        => 'local',
    smbname       => $facts['hostname'],
    security      => 'user',
    sambaloglevel => 1,
    join_domain   => false,
    globaloptions => {
      'idmap config * : backend' => 'tdb',
      'ldap suffix'              => 'dc=jumpcloud,dc=com',
      'ldap admin dn'            => $ldap_user,
      'ldap ssl'                 => 'no',
      'passdb backend'           => 'ldapsam:ldaps://ldap.jumpcloud.com:636',
    }
  }
}
