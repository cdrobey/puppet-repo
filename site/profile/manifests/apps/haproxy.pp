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

  haproxy::frontend { 'puppet00':
    ipaddress    => $::ipaddress,
    ports        => '8140',
    mode         => 'tcp',
    bind_options => 'accept-proxy',
    options      => {
      'default_backend' => 'puppet_backend00',
      'timeout client'  => '30s',
      'option'          => [
        'tcplog',
        'accept-invalid-http-request',
      ],
    },
  }

  haproxy::backend { 'be00':
    options => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'roundrobin',
      'server'  => 'server web03 127.0.0.1:8443 check'
    },
  }
}
