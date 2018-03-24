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
      image           => $docker['base'],
      detach          => $docker['true'],
      service_prefix  => $docker['prefix'],
      ports           => $docker['ports'],
      expose          => $docker['expose'],
      net             => $docker['net'],
      disable_network => $docker['false'],
      volumes         => $docker['volumes'],
      restart_service => $docker['restart'],
    }
  }
}
