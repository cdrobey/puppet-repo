# unifi
#
# Install and configure unifi centralized management station profile.
#
# @summary  This profiles uses the unifi module to configure an installation of a unifi management
#           station.  The module loads the application from the primary ubiquiti application reposibioties.
#           Unifi requires a series of firewall port be opened for proper communication with network devices.
#
# @param    none
#
# @example
#   include profile::windows or assign in PE classifier
# == Class: profile::apps::unifi
class profile::apps::unifi (
  $repo_release = 'stable',
  $package_ensure = 'latest',
){
  firewall { '200 allow unifi access':
    dport  => [80, 443, 8080, 8443, 8843, 8880, 3478, 6789, 10001],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '200 allow unifi access':
    dport  => [ 3478 ],
    proto  => udp,
    action =>  accept,
  }
  class { 'unifi':
    repo_release   => $repo_release,
    package_ensure => $package_ensure,
  }
}
