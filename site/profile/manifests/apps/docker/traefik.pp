# traefik
#
# Install and configure a traefik reverse proxy docker container for https.
#
# @summary  This profiles deploys the traefik docker
#
# @param    none   - provides the location of the influxdb
#
# @example
#   include profile::app::docker::traefik or assign in PE classifier
# == Class: profile::app::docker::traefik
class profile::apps::docker::traefik(
  String $private = 'private-network',
  String $public = 'public-network',
) {
  ['80','443','10000'].each |$port| {
    firewall { "502 tcp traefik ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
  }

  file { '/etc/traefik':
    ensure => directory,
  }

  file { '/etc/traefik/acme.json':
    ensure  => file,
    mode    => '0600',

    require => File['/etc/traefik']
  }

  file { '/etc/traefik/traefik.toml':
    ensure  => file,
    mode    => '0644',
    source  => 'puppet:///modules/profile/apps/traefik.epp',
    require => File['/etc/traefik']
  }

  docker_volume { 'traefik-volume':
    ensure => present,
  }

  docker::image { 'traefik':
    image     => 'traefik/traefik',
    image_tag => 'latest'

  }
  docker::run { 'traefik':
    image           => 'traefik:v1.7.16-alpine',
    ports           => ['80:80','443:443'],
    volumes         => [ '/etc/traefik/traefik.toml:/etc/traefik/traefik.toml',
                          '/etc/traefik/acme.json:/etc/traefik/acme.json',
                          '/var/run/docker.sock:/var/run/docker.sock'],
    labels          => ['traefik.frontend.rule=Host:traefik.local.familyroberson.com',
                        'traefik.port=8080'],
    net             => $public,
    restart_service => false,
    pull_on_start   => false,
    docker_service  => true,
    require         => File['/etc/traefik/traefik.toml']
  }
}
