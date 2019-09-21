# ups
#
# Install and configure unifi centralized management station profile.
#
# @summary  This profiles configure apcups to read ups metrics from a connected system.  The package installation
#           configures apcupsd and a shellscrpt is deployed that formats the data for telegraf.
#
# @param    none
#
# @example
#   include profile::windows or assign in PE classifier
# == Class: profile::apps::unifi
class profile::apps::ups (
  String $package_resource = 'installed',
){
  package { 'apcupsd':
    ensure  => $package_resource,
  }
  package {'bc':
    ensure => $package_resource}

  file { '/etc/apcupsd/ups_metrics.sh':
    ensure => file,
    mode   => '0777',
    source => 'puppet:///modules/profile/apps/ups_metrics.epp',
  }
}
