# == Class: profile::docker
class profile::docker
{
  include 'docker'

  docker::image { 'jacobalberty/unifi':
    ensure    => 'present',
  }
}
