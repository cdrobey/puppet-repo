# == Class: profile::windows::time
class profile::windows::time {
  class { 'winntp':
    servers => lookup('ntp::servers'),
  }
  dsc_xtimezone { 'set timezone':
    dsc_timezone         => 'Central Standard Time',
    dsc_issingleinstance => 'yes',
    require              => Package['powershell'],
  }
}
