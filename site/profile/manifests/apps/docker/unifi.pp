# unifi
#
# Install and configure unifi docker container for network management.
#
# @summary  This profiles deployes the unifi docker
#
# @param    none   - provides the location of the influxdb
#
# @example
#   include profile::app::docker::unifi or assign in PE classifier
# == Class: profile::app::docker::unifi
class profile::apps::docker::unifi(
  String $private = 'private-network',
  String $public = 'public-network',
)
{
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

  docker_volume { 'unifi-volume':
    ensure => 'present',
  }

  docker::image { 'unifi':
    image     => 'linuxserver/unifi',
    image_tag => 'unstable'

  }
  docker::run { 'unifi':
    image           => 'linuxserver/unifi:unstable',
    ports           => ['3478:3478','10001:10001','8080:8080','8081:8081','8443:8443','8843:8843','8880:8880','6789:6789'],
    volumes         => ['unifi-volume:/config'],
    labels          => ['traefik.backend=unifi',
                        'traefik.frontend.rule=Host:unifi.local.familyroberson.com',
                        'traefik.docker.network=public-network',
                        'traefik.port=8443'],
    net             => $public,
    restart_service => false,
    pull_on_start   => false,
    docker_service  => true,
  }
}
