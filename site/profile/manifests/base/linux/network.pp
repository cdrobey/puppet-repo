# network
#
# Install and configure base network profile.
#
# @summary  This profile configures the network service on a linux client.  Using parameters from hiera
#           the modules configures the network interfaces.
#
# @param    interfaces - provides the network intfaces to confirgure
#           network_servers - hased list of network servers used for network settings
#
# @example
#   include profile::base::linux::network or assign in PE classifier
# == Class: profile::base::linux::network
class profile::base::linux::network (
  $interfaces,
  $nameservers,
  $searchpath,
) {
  class { 'network':
    interfaces_hash => $interfaces,
  }

  package { 'resolvconf':
    ensure => purge,
    name   => 'resolvconf',
  }
class { 'resolv_conf':
    nameservers => ['192.168.1.1', '192.168.2.2', '192.168.3.3'],
    searchpath  => ['sub1.example.com', 'sub2.example.com'],
}
}
