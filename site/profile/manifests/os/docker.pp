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
  Hash $docker_list = {},
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
    dport  => [80, 443, 12080, 8443],
    proto  => tcp,
    action =>  accept,
  }

  class { 'docker':
    version   => 'latest',
  }
  docker::image { 'unifi':
    image => 'linuxserver/unifi',

  }
  docker::run { 'unifi':
    image           => 'linuxserver/unifi',
    service_prefix  => 'docker',
    expose          => ['3478','10001','8080','8081','8443','8843','8880','6789'],
    ports           => ['3478','10001','8080','8081','8443','8843','8880','6789'],
    volumes         => ['/unifi', '/config'],
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
  }



# $docker_list.each | $docker_name, $docker | {
#   docker::image { $docker['image']:
#   }
#
#    docker::run { $docker_name:
#      image           => $docker['image'],
#      service_prefix  => $docker['service_prefix'],
#      expose          => $docker['expose'],
#      ports           => $docker['ports'],
#      volumes         => $docker['volumes'],
#      env             => $docker['env'],
#      links           => $docker['links'],
#      restart_service => true,
#      pull_on_start   => false,
#      docker_service  => true,
#    }
#  }
}
