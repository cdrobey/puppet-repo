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
){
  include haproxy

  firewall { '300 allow communication to InfluxDB and Grafana':
    dport  => [80, 443],
    proto  => tcp,
    action =>  accept,
  }

  $listeners.each | $listener_name, $listener_data | {
    haproxy::listen { $listener_name:
      ipaddress => $listener_data['ipaddress'],
      ports     => $listener_data['ports'],
    }
    Haproxy::Balancermember <<| listening_service == $listener_name |>>

  }
}
