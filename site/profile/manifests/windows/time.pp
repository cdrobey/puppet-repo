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

  dsc_systemlocale { 'set timezone':
    dsc_systemlocale     => 'en-us',
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
    notify               => Reboot['dsc_reboot'],
  }

  dsc_xtimezone { 'set timezone':
    dsc_timezone         => $timezone,
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
  }
}
