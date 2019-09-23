# plex
#
# Install and configure a plex docker container for cluster management.
#
# @summary  This profiles deployes the plex docker
#
# @param    none   - provides the location of the influxdb
#
# @example
#   include profile::apps::docker::plex or assign in PE classifier
# == Class: profile::apps::docker::plex
class profile::apps::docker::plex (
  String $private = 'private-network',
  String $public = 'public-network',

) {
  ['32400','3005','8324','32469','1900','32410','32412','32413','32414'].each |$port| {
    firewall { "400 plex ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
  }
  ['32400','3005','8324','32469','1900','32410','32412','32413','32414'].each |$port| {
    firewall { "401 udp plex ${port}":
      proto  => 'udp',
      dport  => $port,
      action => 'accept',
    }
  }

  docker_volume { 'plex-volume':
    ensure => present,
  }

  docker::image { 'plex':
    image     => 'plexinc/pms-docker',
    image_tag => 'latest'

  }
  docker::run { 'plex':
    image           => 'plexinc/pms-docker:latest',
    ports           => ['32400:32400','3005:3005','8324:8324','32469:32469','1900:1900','32410:32410','32412:32412','32413:32413'],
    volumes         => ['plex-volume:/config', 'plex-volume:/transcode', 'plex-volume:/data'],
    labels          => ['traefik.backend=pms-docker',
                        'traefik.frontend.rule=Host:plex.local.familyroberson.com',
                        'traefik.docker.network=public-network',
                        'traefik.port=32400'],
    net             => $public,
    restart_service => false,
    pull_on_start   => false,
    docker_service  => true,
  }
}
