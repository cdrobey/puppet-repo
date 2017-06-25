# == Class: profile::docker
class profile::docker
{
  include 'docker'

  docker::image { 'jacobalberty/unifi':
    ensure    => 'present',
    image_tag => '5.5.1u'
  }
}
