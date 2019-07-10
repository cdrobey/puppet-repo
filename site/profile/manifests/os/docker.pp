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

  ['3478','10001'].each |$port| {
    firewall { "300 unifi UDP ${port}":
      proto  => 'udp',
      dport  => $port,
      action => 'accept',
    }
  }

  ['8080','8081','8443','8843','8880','6789'].each |$port| {
    firewall { "300 unifi TCP ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
  }

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

  class { 'docker':
    version   => 'latest',
  }

  docker_network { 'unifi-network':
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.100.0/24',
    gateway     => '172.16.100.1',
    ip_range    => '172.16.1.0/24'
  }

  docker_volume { 'unifi-volume':
    ensure => present,
  }

  docker::image { 'unifi':
    image     => 'linuxserver/unifi',
    image_tag => 'unstable'

  }
  docker::run { 'unifi':
    image           => 'linuxserver/unifi:unstable',
    ports           => ['3478:3478','10001:10001','8080:8080','8081:8081','8443:8443','8843:8843','8880:8880','6789:6789'],
    volumes         => ['unifi-volume:/config'],
    net             => 'unifi-network',
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
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
    ports           => ['32400:32400','3005:3005','8324:8324','32469:32469','1900:1900','32410:32410','32412:32412','32413:32413','32414:32414'],
    volumes         => ['plex-volume:/config', 'plex-volume:/transcode', 'plex-volume:/data'],
    net             => 'plex-network',
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
  }


  ['12080','12081'].each |$port| {
    firewall { "401 udp media ${port}":
      proto  => 'udp',
      dport  => $port,
      action => 'accept',
    }
  }

  docker_network { 'media-network':
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.102.0/24',
    gateway     => '172.16.102.1',
    ip_range    => '172.16.102.0/24'
  }

  docker_volume { 'media-volume':
    ensure  => present,
    driver  => 'local',
    options => ['o=addr=co-dsm62-p01.local.familyroberson.com,rw', 'device=:/volume1/media'],
  }
  docker::image { 'organizr':
    image     => 'lsiocommunity/organizr',
    image_tag => 'latest'
  }
  docker::run { 'organizr':
    image           => 'lsiocommunity/organizr:latest',
    ports           => ['12081:80' ],
    volumes         => ['media-volume:/organizr/config', 'media-volume:/shared'],
    net             => 'media-network',
    env             => ['TZ=America/Denver', 'PGUID=1000', 'PGGID=1000'],
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
  }
}
