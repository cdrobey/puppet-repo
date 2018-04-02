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
  class { 'docker':
    version   => 'latest',
  }
  $docker_list.each | $docker_name, $docker | {
    docker::image { $docker['image']:
    }

    docker::run { $docker_name:
      ensure         => true,
      image          => $docker['image'],
      detach         => $docker['detach'],
      service_prefix => $docker['service_prefix'],
      expose         => $docker['expose'],
      ports          => $docker['ports'],
      volumes        => $docker['volumes'],
      pull_on_start  => false,
      before_stop    => 'echo "So Long, and Thanks for All the Fish"',
      before_start   => 'echo "Run this on the host before starting the Docker container"',

    }
  }
}
