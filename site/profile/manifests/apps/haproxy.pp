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
    mode    => 'tcp',
    options => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
    },
    bind    => {
      '10.1.1.56:80' => ['ssl', 'crt', 'unifi.fr.lan'],
    },
  }

  haproxy::balancermember { 'bm00':
    listening_service => 'lb00',
    server_names      => $facts['fqdn'],
    ipaddresses       => $facts['ipaddress'],
    ports             => '8443',
    options           => 'check',
  }
}
