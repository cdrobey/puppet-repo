# portainer
#
# Install and configure a portainer docker container for cluster management.
#
# @summary  This profiles deployes the portainer docker
#
# @param    none   - provides the location of the influxdb
#
# @example
#   include profile::app::docker::portainer or assign in PE classifier
# == Class: profile::app::dockeer::portainer
class profile::apps::docker::portainer(
  String $private = 'private-network',
  String $public = 'public-network',
)
{
  ['9000'].each |$port| {
    firewall { "501 tcp portainer ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
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
    labels          => ['traefik.backend=portainer',
                        'traefik.frontend.rule=Host:portainer.local.familyroberson.com',
                        'traefik.docker.network=public-network',
                        'traefik.port=9000'],
    net             => $public,
    restart_service => false,
    pull_on_start   => false,
    docker_service  => true,
  }
}
