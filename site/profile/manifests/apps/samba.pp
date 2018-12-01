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
    joindomain         => false,
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

  # recover uid and gid from Domain Controler (unix attributes)
  samba::idmap { 'Domain DC':
    domain      => 'DC',
    idrangemin  => 10000,
    idrangemax  => 19999,
    backend     => 'ad',
    schema_mode => 'rfc2307',
  }

  # a default map (*) is needed for idmap to work
  samba::idmap { 'Domain *':
    domain     => '*',
    idrangemin => 100000,
    idrangemax => 199999,
    backend    => 'tdb',
  }
#  $users.each | $user_name, $user | {
#    smb_user {$user_name:
#      ensure   => present,
#      password => $user['password']
#    }
#  }
}
