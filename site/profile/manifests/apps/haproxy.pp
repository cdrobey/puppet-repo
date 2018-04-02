# haproxy
#
# Use haproxy modules to setup a load balancer.
#
# @summary  This profiles installes a haproxy loadbalancer to provide connection management.
#           A list of applications and ports may be specified in hiera files.
#
# @param    apps - a hased list of application rc scripts mapped to setup a test environment on boot of 
#           server
#
# @example
#   include profile::haproxy or assign in PE classifier
# == Class: profile::apps::haproxy
class profile::apps::haproxy (
){
  include haproxy
  haproxy::listen { 'lb00':
    collect_exported => false,
    ipaddress        => $facts['ipaddress'],
    ports            => '80',
  }
  haproxy::balancermember { 'bm00':
    listening_service => 'lb00',
    server_names      => $facts['fqdn'],
    ipaddress         => $facts['ipaddress'],
    ports             => '80',
    options           => 'check',
  }
}
