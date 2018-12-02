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
  String $nodename = 'nas',
  String $workgroup = 'local',
  String $realm = 'local.nas',
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
    domain         => $workgroup,
    realm          => $realm,
    smbname        => $nodename,
    security       => 'user',
    sambaloglevel  => 5,
    join_domain    => false,
    manage_winbind => false,
    krbconf        => false,
    globaloptions  => {
      'local master'   => 'no',
      'passdb backend' => 'smbpasswd'
    }
  }
  smb_user { 'test':
    ensure         => present,
    password       => 'PassW0rd',
    force_password => true,
    groups         => ['domain users'],
  }

  samba::share { 'Test Share':
    path    => '/mnt/fs01/test',
    options => {
      'browsable' => 'Yes',
    },
  }
}
