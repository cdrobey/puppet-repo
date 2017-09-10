# == Class: profile::windows::time
class profile::windows::time (
  $timezone,
  $ntp_servers,
) {


  # Module relies on puppet-powershelldsc for settingthe time zone.
  # You must enable winrm and execution policy.
  registry_value { 'HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell\ExecutionPolicy':
    ensure => present,
    data   => 'Unrestricted',
  }

  dsc_xtimezone { 'set timezone':
    dsc_timezone         => 'Mountain Standard Time',
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
  }
}
