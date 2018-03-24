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
  $docker_list,
){
  class { 'docker':
    version => 'latest',
  }
  $docker_list.each | $docker_name, $docker | {
    docker::run { $docker_name:
      image          => $docker['image'],
      detach         => $docker['detach'],
      service_prefix => $docker['service_prefix'],
      ports          => $docker['ports'],
      expose         => $docker['expose'],
      volumes        => $docker['volumes'],
    }
  }
}
