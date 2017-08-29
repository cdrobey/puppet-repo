# == Class: profile::windows::time
class profile::windows::time (
  $timezone,
  $ntp_servers,
) {
  class { 'winntp':
    servers => $ntp_servers,
  }
  dsc_registry {'registry_test':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\TestKey',
    dsc_valuename => 'TestDwordValue',
    dsc_valuedata => '-2147483648',
    dsc_valuetype => 'Dword',
  }
}
