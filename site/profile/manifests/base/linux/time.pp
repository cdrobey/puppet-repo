# time
#
# Install and configure base time profile.
#
# @summary  This profile configures the time service on a linux client.  Using parameters from hiera
#           the modules configures the ntp server used for time alignment and configures the timezone.
#
# @param    timezone - provides the timezone
#           ntp_servers - hased list of ntp servers used for time settings
#
# @example
#   include profile::base::linux::time or assign in PE classifier
# == Class: profile::base::linux::time
class profile::base::linux::time (
  String $timezone= '/usr/share/zoneinfo/America/Denver',
  Array $ntp_servers = [ 'time.google.com' ],
) {

  class { 'ntp':
    package_ensure => 'present',
    servers        => $ntp_servers,
  }

  file { '/etc/localtime':
    ensure => link,
    target => $timezone,
  }
}
