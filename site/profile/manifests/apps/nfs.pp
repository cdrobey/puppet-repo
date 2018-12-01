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
  Hash $exports = {},
){

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
    firewall { '304 allow udp communication to mountd':
    dport  => [20048],
    proto  => udp,
    action =>  accept,
  }
  firewall { '305 allow tcp communication to mountd':
    dport  => [20048],
    proto  => tcp,
    action =>  accept,
  }
  class { 'nfs':
    server_enabled => true
  }
  nfs::server::export{ '/mnt/fs01/vmware':
    ensure  => 'mounted',
    clients => '10.1.1.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
  }
}
