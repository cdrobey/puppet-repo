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
  $rdp_enable,
  $rdp_nla_enable,
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

  windows_firewall::exception { 'WINRM':
    ensure       => present,
    direction    => 'in',
    action       => 'Allow',
    enabled      => 'yes',
    protocol     => 'TCP',
    local_port   => '5985',
    remote_port  => 'any',
    display_name => 'Windows Remote Management HTTP-In',
    description  => 'Inbound rule for Windows Remote Management via WS-Management. [TCP 5985]',
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
    data   => '0x000927c0',
    notify => Reboot['rdp_reboot'],
  }

  # Set time limit for disconnected sessions: 5 minutes
  registry_value { 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Terminal Services\MaxDisconnectionTime':
    type   => dword,
    data   => '0x000493e0',
    notify => Reboot['rdp_reboot'],
  }

  reboot { 'rdp_reboot':
    apply => finished,
  }
}
