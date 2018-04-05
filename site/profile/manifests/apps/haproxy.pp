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
  Hash $listeners,
# Hash $balancers,
){
  include haproxy

  $listeners.each | $listener_name, $listener_data | {
    haproxy::listen { $listener_name:
      collect_exported => $listener_data['collect_exported'],
      ipaddress        => $listener_data['ipaddress'],
      ports            => $listener_data['ports'],
    }
  }
  #$balancers.each | $balancer_name, $balancer_data | {
  #  haproxy::balancermember { $balancer_name:
  #    listening_service => $balancer_data['listening_service'],
  #    server_names      => $balancer_data['server_names'],
  #    ipaddresses       => $balancer_data['ipaddresses'],
  #    ports             => $balancer_data['ports'],
  #    options           => $balancer_data['options'],
  #  }
#  }
Haproxy::Balancermember <<| listening_service == 'unifi' |>>
}
