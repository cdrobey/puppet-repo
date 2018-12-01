# nfs
#
# Install and configure nfs file server profile.
#
# @summary  This profiles uses the several modules to configure an installation of a file server.  The module loads the application from the primary ubiquiti application reposibioties.
# 
#
# @param    none
#
# @example
#   include profile::apps::nfs or assign in PE classifier
# == Class: profile::apps::nfs
class profile::apps::nfs (
  Hash $exports = undef,
){

  firewall { '300 allow tcp communication to smbd/nbmd':
    dport  => [137, 138, 139, 445],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '300 allow udp communication to nfsd':
    dport  => [111],
    proto  => udp,
    action =>  accept,
  }
  firewall { '301 allow tcp communication to nfsd':
    dport  => [111],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '302 allow udp communication to nfsd':
    dport  => [2049],
    proto  => udp,
    action =>  accept,
  }
  firewall { '303 allow tcp communication to nfsd':
    dport  => [2049],
    proto  => tcp,
    action =>  accept,
  }

  class { 'nfs':
      server_enabled => true
  }
  nfs::server::export{ '/data_folder':
      ensure  => 'mounted',
      clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
    }
  }

  $exports.each | $export_name, $exports | {
    nfs::server::share { $export_name:
      ensure  => 'mounted'
      clients => $exports['clients'],
    }
  }
}
