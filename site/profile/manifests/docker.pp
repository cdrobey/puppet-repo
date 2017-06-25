# == Class: profile::docker
class profile::docker
{
  include 'docker'

  docker::image { 'jacobalberty/unifi':
    ensure    => 'present',
  }
  docker::run { 'unifi':
    image            => 'jacobalberty/unifi',
    ports            => ['3478', '6789', 8080, 8443, 8880, 8843],
    expose           => ['3478', '6789', 8080, 8443, 8880, 8843],
    volumes          => ['/var/lib/couchdb', '/var/log'],
    volumes_to       => [ '/var/lib/unifi', '/var/log/unifi' ],
    restart_service  => true,
    extra_parameters => [ '--restart=always' ],
  }
}
