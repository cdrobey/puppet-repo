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
  String $workgroup,
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
    realm          => '*',
    smbname        => $facts['hostname'],
    security       => 'user',
    sambaloglevel  => 5,
    join_domain    => false,
    manage_winbind => false,
    krbconf        => false,
    options        => {
      'local master'   => 'no',
      'passdb backend' => 'smbpasswd'
    }
  }
  samba::share { 'Test Share':
    path    => '/mnt/fs00/test',
    options => {
      'browsable' => 'Yes',
    },
  }
}
