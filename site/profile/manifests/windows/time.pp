# == Class: profile::windows::time
class profile::windows::time (
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

  dsc_xtimezone { 'set timezone':
  #dsc_timezone         => 'Mountain Standard Time',
    dsc_timezone         => $timezone,
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
  }
}
