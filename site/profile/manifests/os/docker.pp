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
  class { 'docker':
    version   => 'latest',
  }
  docker::image { 'linuxserver/unifi':
    image_tag => 'latest',

  }
  docker::run { 'linuxserver/unifi':
    image           => 'linuxserver/unifi',
    service_prefix  => 'docker',
    expose          => ['3478:3478','10001:10001','8080:8080','8081:8081','8443:8443','8843:8843','8880:8880','6789:6789'],
    volumes         => ['/unifi:/config'],
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
    net             => 'unifi-network',
  }


  ['3478','10001','8080','8081','8443','8843','8880','6789'].each |$port| {
    firewall { "300 unifi ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
  }

  docker_network { 'unifi-network':
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.100.0/24',
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
