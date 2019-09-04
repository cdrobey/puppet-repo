# plex
#
# Install and configure a plex docker container for cluster management.
#
# @summary  This profiles deployes the plex docker
#
# @param    none   - provides the location of the influxdb
#
# @example
#   include profile::app::plex or assign in PE classifier
# == Class: profile::app::plex
class profile::apps::plex
{
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

  docker_network { 'plex-network':
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.101.0/24',
    gateway     => '172.16.101.1',
    ip_range    => '172.16.101.0/24'
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
    net             => 'plex-network',
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
  }
}
