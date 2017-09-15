# == Class: profile::windows::rdp
class profile::windows::rdp (
  $rdp_enable,
  $rdp_nla_enable,
  ){
  class { 'rdp':
    rdp_enable     => $rdp_enable,
    rdp_nla_enable => $rdp_nla_enable,
  }

  windows_firewall::exception { 'rdp':
        ensure       => present,
        direction    => 'in',
        action       => 'Allow',
        enabled      => 'yes',
        protocol     => 'TCP',
        local_port   => '3389',
        remote_port  => 'any',
        display_name => 'Remote Desktop',
        description  => 'Inbound rule for RDP. [TCP 3389]',
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
