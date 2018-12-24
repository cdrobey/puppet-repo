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
# test comment
class profile::apps::nginx (
  Array $serverlist,
  Integer $proxyport,
  Hash $proxylist,
  Array $proxysetheaders,
){

  firewall { '300 allow communication to InfluxDB and Grafana':
    dport  => [80, 443],
    proto  => tcp,
    action =>  accept,
  }

  class { 'nginx': }

  #nginx::resource::server { 'default':
  #  use_default_location => false,
  #  server_name          => ['*.familyroberson.com'],
  #  index_files          => [],
  # server_cfg_append    => { 'return' => '301 https://*.familyroberson.com?request_uri' },
  #

  $proxylist.each | $proxy_name, $proxy | {
    nginx::resource::server { "${proxy_name}-80":
          server_name      => [ $proxy_name ],

      server_name          => $proxy_name,
      listen_port          => 80,
      use_default_location => false,
      index_files          => [],
      server_cfg_append    => { 'return' => '301 https://$host$request_uri' },
    }

    nginx::resource::server{ "${proxy_name}-443":
      server_name      => [ $proxy_name ],
      listen_port      => 443,
      ssl              => true,
      ssl_cert         => '/etc/ssl/public/familyroberson.crt',
      ssl_key          => '/etc/ssl/public/familyroberson.key',
      proxy            => $proxy['proxy'],
      proxy_set_header => $proxysetheaders,
    }
  }
}
