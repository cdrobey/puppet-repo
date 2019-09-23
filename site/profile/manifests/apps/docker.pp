# docker
#
# Install and configure docker for management of images.
#
# @summary  This profiles deployes the basic docker server setup.
#
# @example
#   include profile::apps::docker or assign in PE classifier
# == Class: profile::apps::docker
class profile::apps::docker(
  String $private = 'private-network',
  String $public = 'public-network',
) {
  class { 'docker':
    version   => 'latest',
  }


  docker_network { $public:
    ensure => 'present',
    driver => 'bridge',
  }
  include profile::apps::docker::unifi
  include profile::apps::docker::portainer
  include profile::apps::docker::plex
  include profile::apps::docker::traefik
}
