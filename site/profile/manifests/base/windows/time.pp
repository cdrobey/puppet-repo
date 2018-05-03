# time
#
# Install and configure base time profile.
#
# @summary  This profile configures the time service on a window client.  Using parameters from hiera
#           the modules confgurations the ntp server used for time alignment and configures the timezone.
#
# @param    timezone - provides the timezone
#           ntp_servers - hased list of ntp servers used for time settings
#
# @example
#   include profile::base::windows::time or assign in PE classifier
# == Class: profile::base::windows::time
class profile::base::windows::time (
  $timezone,
  $ntp_servers,
) {
  class { 'winntp':
    servers => $ntp_servers,
  }

  registry_value { 'HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell\ExecutionPolicy':
    ensure => present,
    data   => 'Unrestricted',
  }

  dsc_systemlocale { 'set systmelocale':
    dsc_systemlocale     => 'en-us',
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
  }

  dsc_xtimezone { 'set timezone':
    dsc_timezone         => $timezone,
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
  }
}
