# traefik
#
# Install and configure a traefik reverse proxy docker container for https.
#
# @summary  This profiles deploys the traefik docker
#
# @param    none   - provides the location of the influxdb
#
# @example
#   include profile::app::traefik or assign in PE classifier
# == Class: profile::app::traefik
class profile::apps::traefik
{
  ['80','443','10000'].each |$port| {
    firewall { "502 tcp traefik ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
  }

  file { '/tmp/traefik.toml':
    ensure => file,
    mode   => '0777',
    source => 'puppet:///modules/profile/apps/traefik.epp',
  }


  docker_network { 'traefik-network':
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.16.104.0/24',
    gateway     => '172.16.104.1',
    ip_range    => '172.16.104.0/24'
  }

  docker_volume { 'traefik-volume':
    ensure => present,
  }

  docker::image { 'traefik':
    image     => 'traefik/traefik',
    image_tag => 'latest'

  }
  docker::run { 'traefik':
    image           => 'traefik:latest',
    ports           => ['80:80','443:443','10000:10000'],
    volumes         => ['/tmp/traefik.toml:/etc/traefik/traefik.toml', '/var/run/docker.sock:/var/run/docker.sock'],
    net             => 'traefik-network',
    restart_service => true,
    pull_on_start   => false,
    docker_service  => true,
  }
}
