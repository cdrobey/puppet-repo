# nginx
#
# Use nginx modules to setup a load balancer/reverse proxy.
#
# @summary  This profile installs a nginx loadbalancer/reverse proxy to provide connection management.
#           A list of applications and ports may be specified in hiera files.
#
# @param    listeners - a hased list of application using the service
#
# @example
#   include profile::apps::nginx or assign in PE classifier
# == Class: profile::apps::nginx
class profile::apps::nginx (
  Hash $listeners,
){

  firewall { '300 allow communication to InfluxDB and Grafana':
    dport  => [80, 443],
    proto  => tcp,
    action =>  accept,
  }

  include nginx

  $listeners.each | $listener_name, $listener_data | {
    nginx::resource::server { $listener_name:
      ssl         => true,
      listen_port => $listener_data['port'],
      proxy       => $listener_data['proxy'],
    }
  }
}
