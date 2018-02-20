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
  $workgroup,
  $users,
  $shares,
){
  class {'samba::server':
    workgroup     => $workgroup,
    server_string => 'Samba Server',
    security      => 'share'
  }

  $shares.each | $share_name, $share | {
    samba::server::share {'$share_name':
      comment   => $share['comment'],
      path      => $share['path'],
      browsable => $share['browsable'],
    }
  }
  $users.each | $user_name, $user | {
    samba::server::share {'$user_name':
      password => $user['password']
    }
  }
}
