# == Class: profile::docker
class profile::docker
{
  include 'docker'

  file {
    default:
      mode   => '0777',
      owner  => 'root',
      group  => 'root',
  }

  file {'unifi_main':
    ensure => directory,
    target => '/unifi',
  }
  file {'unifi_log':
    ensure  => directory,
    target  => '/unifi/log',
    require => 'unifi_main',
  }
  file {'unifi_lib':
    ensure => directory,
    target => '/unifi/lib',
    require => 'unifi_main',
  }

  docker::image { 'jacobalberty/unifi':
    ensure    => 'present',
  }
  docker::run { 'unifi':
    image            => 'jacobalberty/unifi',
    ports            => ['3478', '6789', 8080, 8443, 8880, 8843],
    expose           => ['3478', '6789', 8080, 8443, 8880, 8843],
    volumes          => ['/var/lib/couchdb', '/var/log'],
    volumes_from     => [ '/var/lib/unifi', '/var/log/unifi' ],
    restart_service  => true,
    extra_parameters => [ '--restart=always' ],
  }
}
