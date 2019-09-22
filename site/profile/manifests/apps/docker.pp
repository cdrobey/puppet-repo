# docker
#
# Install and configure docker for management of images.
#
# @summary  This profiles deployes the basic docker server setup.
#
# @example
#   include profile::app::docker or assign in PE classifier
# == Class: profile::app::docker
class profile::app::docker(
  String $private = 'private-network',
  String $public = 'public-network',
) {
  class { 'docker':
    version   => 'latest',
  }

  docker_network { $private:
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.100.0/24',
    gateway     => '172.16.100.1',
    ip_range    => '172.16.100.0/24'
  }
  docker_network { $public:
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.100.0/24',
    gateway     => '172.16.200.1',
    ip_range    => '172.16.100.0/24'
  }
}
