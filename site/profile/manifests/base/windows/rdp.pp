# rdp
#
# Install and configure base rdp profile.
#
# @summary  This profile configures the rdp service on a window client.  Using parameters from hiera
#           the modules enables/disables the rdp service for access.
#
# @param    rdp_enable - enable/disable the services.
#           rdp_nla_enable - enable/disable certificate based access.
#
# @example
#   include profile::base::windows::rdp or assign in PE classifier
# == Class: profile::base::windows::rdp
class profile::base::windows::rdp (
  Boolean $rdp_enable,
  Boolean $rdp_nla_enable,
  String $rdp_disconnect = '0x000493e0',
  String $rdp_idle = '0x0001B7740',

){
  # Remote Desktop Connection logic (Remote Desktop is enabled = 0, Remote Desktop is disabled = 1)
  if $rdp_enable {
    $rdp_setting = '0'
  }
  else {
    $rdp_setting = '1'
  }

  # Remote Desktop Network Level Authentication logic (Remote Desktop NLA is enabled = 1, Remote Desktop NLA is disabled = 0)
  if $rdp_nla_enable {
    $rdp_nla_setting = '1'
  }
  else {
    $rdp_nla_setting = '0'
  }

  class { 'windows_firewall':
    ensure => 'running' }

  windows_firewall::exception { 'WINRDP-TCP':
    ensure       => present,
    direction    => 'in',
    action       => 'Allow',
    enabled      => 'yes',
    protocol     => 'TCP',
    local_port   => '3389',
    remote_port  => 'any',
    display_name => 'Windows Remote Desktop (TCP-IN)',
    description  => 'Inbound rule for Windows Remote Desktop via TCP. [TCP 3389]',
  }
  windows_firewall::exception { 'WINRDP-UDP':
    ensure       => present,
    direction    => 'in',
    action       => 'Allow',
    enabled      => 'yes',
    protocol     => 'UDP',
    local_port   => '3389',
    remote_port  => 'any',
    display_name => 'Windows Remote Desktop (UDP-IN)',
    description  => 'Inbound rule for Windows Remote Desktop via UDP. [UDP 3389]',
  }

  # Remote Desktop Connection
  registry::value { 'rdp':
    key   => 'HKLM\System\CurrentControlSet\Control\Terminal Server',
    value => 'fDenyTSConnections',
    type  => 'dword',
    data  => $rdp_setting,
  }

  # Remote Desktop Network Level Authentication
  registry::value { 'rdp_nla':
    key   => 'HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp',
    value => 'UserAuthentication',
    type  => 'dword',
    data  => $rdp_nla_setting,
  }

  # Set time limit for active but idle Remote Desktop Services sessions: 10 minutes
  registry_value { 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Terminal Services\MaxIdleTime':
    type   => dword,
    data   => $rdp_disconnect,
    notify => Reboot['rdp_reboot'],
  }

  # Set time limit for disconnected sessions: 5 minutes
  registry_value { 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Terminal Services\MaxDisconnectionTime':
    type   => dword,
    data   => $rdp_idle,
    notify => Reboot['rdp_reboot'],
  }

  reboot { 'rdp_reboot':
    apply => finished,
  }
}
