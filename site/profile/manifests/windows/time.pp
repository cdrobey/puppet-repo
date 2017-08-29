# == Class: profile::windows::time
class profile::windows::time (
  $timezone,
  $ntp_servers,
) {
  class { 'winntp':
    servers => $ntp_servers,
  }

  dsc_xtimezone { 'set timezone':
    dsc_timezone         => 'Central Standard Time',
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
  }
}
