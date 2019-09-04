# portainer
#
# Install and configure a portainer docker container for cluster management.
#
# @summary  This profiles deployes the portainer docker
#
# @param    none   - provides the location of the influxdb
#
# @example
#   include profile::app::portainer or assign in PE classifier
# == Class: profile::app::portainer
class profile::apps::portainer
{
  ['9000'].each |$port| {
    firewall { "501 tcp portainer ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
  }
  docker_network { 'portainer-network':
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.103.0/24',
    gateway     => '172.16.103.1',
    ip_range    => '172.16.103.0/24'
  }

  docker_volume { 'portainer-volume':
    ensure => present,
  }

  docker::image { 'portainer':
    image     => 'portainer/portainer',
    image_tag => 'latest'

  }
  docker::run { 'portainer':
    image           => 'portainer/portainer:latest',
    ports           => ['9000:9000'],
    volumes         => ['portainer_data:/data', '/var/run/docker.sock:/var/run/docker.sock'],
    net             => 'portainer-network',
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
  }
}
