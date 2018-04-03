# docker
#
# Install and configure docker for management of images.
#
# @summary  This profiles deployes the docker configuration and images based upon hiera 
#           configuration.
#
# @param    influxdburi   - provides the location of the influxdb
#           influxdbname  - name of the db instance for storing data
#
# @example
#   include profile::os::docker or assign in PE classifier
# == Class: profile::os::docker
class profile::os::docker (
  Hash $docker_list = undef,
){
  sysctl { 'net.ipv4.ip_forward':
    ensure => present,
    value  => '1',
  }

  firewall { '100 snat for network ens192':
    chain    => 'POSTROUTING',
    jump     => 'MASQUERADE',
    proto    => 'all',
    outiface => 'ens192',
    table    => 'nat',
  }
  firewall { '200 allow http/https access':
    dport  => [80, 443],
    proto  => tcp,
    action =>  accept,
  }

  class { 'docker':
    version   => 'latest',
  }

  $docker_list.each | $docker_name, $docker | {
    docker::image { $docker['image']:
    }

    docker::run { $docker_name:
      image           => $docker['image'],
      service_prefix  => $docker['service_prefix'],
      expose          => $docker['expose'],
      ports           => $docker['ports'],
      volumes         => $docker['volumes'],
      env             => $docker['env'],
      links           => $docker['links'],
      restart_service => true,
      pull_on_start   => false,
      docker_service  => true,
    }
  }
}
