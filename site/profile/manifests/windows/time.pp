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

  reboot { 'dsc_reboot' :
    message => 'DSC has requested a reboot',
    when    => 'pending'
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
