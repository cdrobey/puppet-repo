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
  String $workgroup = 'HOME',
  Hash $users = {},
  Hash $shares = {},
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

  class {'samba::classic':
    workgroup     => $workgroup,
    server_string => 'Samba Server',
    security      => 'user'
  }

  $users.each | $user_name, $user | {
    smb_user {$user_name:
      ensure   => present,
      password => $user['password']
    }
  }
}
