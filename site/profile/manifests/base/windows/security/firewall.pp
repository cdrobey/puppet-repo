# firewall
#
# Install and configure base firewall profile.
#
# @summary  This profile configures the firewall of a windows server after purging the existing firewall
#           configuration.
#
# @param    none
#
# @example
#   include profile::base::windows::security::firewall or assign in PE classifier
# == Class: profile::base::windows::security::firewall
class profile::base::windows::security::firewall {
  Firewall_rule {
    require => undef,
  }
  # Default firewall rules

  firewall_rule { 'Core Networking - DNS (UDP-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Outbound rule to allow DNS requests. DNS responses based on requests that matched this rule will be permitted regardless of source address.  This behavior is classified as loose source mapping. [LSM] [UDP 53]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    local_ports      => '*',
    protocol         => '17',
    remote_ports     => '53',
    service_name     => 'dnscache',
  }

  firewall_rule { 'Core Networking - Destination Unreachable Fragmentation Needed (ICMPv4-In)':
    ensure               => 'present',
    application_name     => 'System',
    description          => 'Destination Unreachable Fragmentation Needed error messages are sent from any node that a packet traverses which is unable to forward the packet because fragmentation was needed and the don’t fragment bit was set.',
    enabled              => true,
    grouping             => '@FirewallAPI.dll,-25000',
    icmp_types_and_codes => '3:4',
    protocol             => '1',
  }

  firewall_rule { 'Core Networking - Dynamic Host Configuration Protocol (DHCP-In)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Allows DHCP (Dynamic Host Configuration Protocol) messages for stateful auto-configuration.',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    local_ports      => '68',
    protocol         => '17',
    remote_ports     => '67',
    service_name     => 'dhcp',
  }

  firewall_rule { 'Core Networking - Dynamic Host Configuration Protocol (DHCP-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Allows DHCP (Dynamic Host Configuration Protocol) messages for stateful auto-configuration.',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    local_ports      => '68',
    protocol         => '17',
    remote_ports     => '67',
    service_name     => 'dhcp',
  }

  firewall_rule { 'Core Networking - Group Policy (LSASS-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\lsass.exe',
    description      => 'Outbound rule to allow remote LSASS traffic for Group Policy updates [TCP].',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    local_ports      => '*',
    profiles         => '1',
    protocol         => '6',
    remote_ports     => '*',
  }

  firewall_rule { 'Core Networking - Group Policy (NP-Out)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Core Networking - Group Policy (NP-Out)',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    local_ports      => '*',
    profiles         => '1',
    protocol         => '6',
    remote_ports     => '445',
  }

  firewall_rule { 'Core Networking - Group Policy (TCP-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Outbound rule to allow remote RPC traffic for Group Policy updates. [TCP]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    local_ports      => '*',
    profiles         => '1',
    protocol         => '6',
    remote_ports     => '*',
  }

  firewall_rule { 'Core Networking - Internet Group Management Protocol (IGMP-In)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'IGMP messages are sent and received by nodes to create, join and depart multicast groups.',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    protocol         => '2',
  }

  firewall_rule { 'Core Networking - Internet Group Management Protocol (IGMP-Out)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'IGMP messages are sent and received by nodes to create, join and depart multicast groups.',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-25000',
    protocol         => '2',
  }

  firewall_rule { 'File and Printer Sharing (Echo Request - ICMPv4-In)':
    ensure               => 'present',
    description          => 'Echo Request messages are sent as ping requests to other nodes.',
    enabled              => true,
    grouping             => '@FirewallAPI.dll,-28502',
    icmp_types_and_codes => '8:*',
    profiles             => '4',
    protocol             => '1',
  }

  firewall_rule { 'Network Discovery (LLMNR-UDP-In)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Inbound rule for Network Discovery to allow Link Local Multicast Name Resolution. [UDP 5355]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '5355',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '*',
    service_name     => 'dnscache',
  }
  firewall_rule { 'Network Discovery (LLMNR-UDP-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Outbound rule for Network Discovery to allow Link Local Multicast Name Resolution. [UDP 5355]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '5355',
    service_name     => 'dnscache',
  }
  firewall_rule { 'Network Discovery (NB-Datagram-In)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Inbound rule for Network Discovery to allow NetBIOS Datagram transmission and reception. [UDP 138]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '138',
    profiles         => '2',
    protocol         => '17',
    remote_ports     => '*',
  }

  firewall_rule { 'Network Discovery (NB-Datagram-Out)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Outbound rule for Network Discovery to allow NetBIOS Datagram transmission and reception. [UDP 138]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '17',
    remote_ports     => '138',
  }

  firewall_rule { 'Network Discovery (NB-Name-In)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Inbound rule for Network Discovery to allow NetBIOS Name Resolution. [UDP 137]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '137',
    profiles         => '2',
    protocol         => '17',
    remote_ports     => '*',
  }

  firewall_rule { 'Network Discovery (NB-Name-Out)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Outbound rule for Network Discovery to allow NetBIOS Name Resolution. [UDP 137]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '17',
    remote_ports     => '137',
  }

  firewall_rule { 'Network Discovery (Pub WSD-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Outbound rule for Network Discovery to discover devices via Function Discovery. [UDP 3702]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '3702',
    service_name     => 'fdrespub',
  }

  firewall_rule { 'Network Discovery (Pub-WSD-In)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Inbound rule for Network Discovery to discover devices via Function Discovery. [UDP 3702]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '3702',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '*',
    service_name     => 'fdrespub',
  }

  firewall_rule { 'Network Discovery (SSDP-In)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Inbound rule for Network Discovery to allow use of the Simple Service Discovery Protocol. [UDP 1900]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '1900',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '*',
    service_name     => 'Ssdpsrv',
  }

  firewall_rule { 'Network Discovery (SSDP-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Outbound rule for Network Discovery to allow use of the Simple Service Discovery Protocol. [UDP 1900]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '1900',
    service_name     => 'Ssdpsrv',
  }

  firewall_rule { 'Network Discovery (WSD Events-In)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Inbound rule for Network Discovery to allow WSDAPI Events via Function Discovery. [TCP 5357]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '5357',
    profiles         => '2',
    protocol         => '6',
    remote_ports     => '*',
  }

  firewall_rule { 'Network Discovery (WSD Events-Out)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Outbound rule for Network Discovery to allow WSDAPI Events via Function Discovery. [TCP 5357]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '6',
    remote_ports     => '5357',
  }

  firewall_rule { 'Network Discovery (WSD EventsSecure-In)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Inbound rule for Network Discovery to allow Secure WSDAPI Events via Function Discovery. [TCP 5358]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '5358',
    profiles         => '2',
    protocol         => '6',
    remote_ports     => '*',
  }

  firewall_rule { 'Network Discovery (WSD EventsSecure-Out)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Outbound rule for Network Discovery to allow Secure WSDAPI Events via Function Discovery. [TCP 5358]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '6',
    remote_ports     => '5358',
  }

  firewall_rule { 'Network Discovery (WSD-In)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Inbound rule for Network Discovery to discover devices via Function Discovery. [UDP 3702]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '3702',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '*',
    service_name     => 'fdphost',
  }

  firewall_rule { 'Network Discovery (WSD-Out)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Outbound rule for Network Discovery to discover devices via Function Discovery. [UDP 3702]',
    direction        => '2',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-32752',
    local_ports      => '*',
    profiles         => '2',
    protocol         => '17',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '3702',
    service_name     => 'fdphost',
  }

  firewall_rule { 'Remote Desktop - Shadow (TCP-In)':
    ensure                 => 'present',
    application_name       => 'C:\windows\system32\RdpSa.exe',
    description            => 'Inbound rule for the Remote Desktop service to allow shadowing of an existing Remote Desktop session. (TCP-In)',
    edge_traversal         => true,
    edge_traversal_options => '2',
    enabled                => true,
    grouping               => '@FirewallAPI.dll,-28752',
    local_ports            => '*',
    profiles               => '7',
    protocol               => '6',
    remote_ports           => '*',
  }

  firewall_rule { 'Remote Desktop - User Mode (TCP-In)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Inbound rule for the Remote Desktop service to allow RDP traffic. [TCP 3389]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-28752',
    local_ports      => '3389',
    profiles         => '7',
    protocol         => '6',
    remote_ports     => '*',
    service_name     => 'termservice',
  }

  firewall_rule { 'Remote Desktop - User Mode (UDP-In)':
    ensure           => 'present',
    application_name => 'C:\windows\system32\svchost.exe',
    description      => 'Inbound rule for the Remote Desktop service to allow RDP traffic. [UDP 3389]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-28752',
    local_ports      => '3389',
    profiles         => '7',
    protocol         => '17',
    remote_ports     => '*',
    service_name     => 'termservice',
  }

  firewall_rule { 'Windows Remote Management (HTTP-In)':
    ensure           => 'present',
    application_name => 'System',
    description      => 'Inbound rule for Windows Remote Management via WS-Management. [TCP 5985]',
    enabled          => true,
    grouping         => '@FirewallAPI.dll,-30267',
    local_ports      => '5985',
    profiles         => '4',
    protocol         => '6',
    remote_addresses => 'LocalSubnet',
    remote_ports     => '*',
  }
}
