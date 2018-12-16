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
class profile::apps::ups (
  String $package_ensure = 'installed',
){
  package { 'apcupsd':
    ensure  => $package_resource,
  }
  package {'bc':
    ensure => $package_resource}

  file { '/etc/apcupsd/ups_metrics.sh':
    ensure  => file,
    mode    => "770",
    source  => 'puppet:///modules/profile/apps/ups_metrics.epp',
  }
}
