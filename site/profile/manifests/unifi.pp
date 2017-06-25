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
  firewall { '200 allow unifi access':
    dport  => [80, 443, 8080, 8443, 8843, 8880, 3478, 6789, 10001],
    proto  => tcp,
    action =>  accept,
  }

  file { '/unifi':
    ensure => directory,
  }
  file { '/unifi/log':
    ensure  => directory,
  }
  file { '/unifi/lib':
    ensure => directory,
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
