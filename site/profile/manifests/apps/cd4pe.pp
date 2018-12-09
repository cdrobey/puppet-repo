# cd4pe
#
# Use CD4PE for delivery of code across Puppet Systems.
#
# @summary  This profiles installes CD4PE and establishes a baseline CI/CD environment for PE.
#           The profile requires a docker environment setup on a systems.
#
# @param    cd4pe_image - docker continer for the cd4pe image.
#
# @example
#   include profile::apps::cd4pe or assign in PE classifier
# == Class: profile::apps::apache

class profile::apps::cd4pe (
  String[1] $cd4pe_image = 'puppet/continuous-delivery-for-puppet-enterprise',
) {
  Docker::Run {
    health_check_interval => 30,
  }

  ['3306', '7000', '8000', '8080', '8081'].each |$port| {
    firewall { "300 allow cd4pe ${port}":
      proto  => 'tcp',
      dport  => $port,
      action => 'accept',
    }
  }

  docker::image { $cd4pe_image:
    image_tag => 'latest',
  }

  docker::image { 'mysql':
    image_tag => '5.7',
  }

  docker::image { 'docker.bintray.io/jfrog/artifactory-oss':
    image_tag => '5.8.3',
  }

  docker_network { 'cd4pe-network':
    ensure      => 'present',
    driver      => 'bridge',
    ipam_driver => 'default',
    subnet      => '172.18.0.0/16',
  }

  docker::run { 'cd4pe-mysql':
    image   => 'mysql:5.7',
    net     => 'cd4pe-network',
    ports   => ['3306:3306'],
    volumes => ['cd4pe-mysql:/var/lib/mysql'],
    env     => [
      'MYSQL_ROOT_PASSWORD=puppetlabs',
      'MYSQL_DATABASE=cd4pe',
      'MYSQL_PASSWORD=puppetlabs',
      'MYSQL_USER=cd4pe',
    ],
  }

  docker_volume { 'data_s3':
    ensure => present,
  }

  archive { 'bootstrap-cd4pe-artifactory-data_s3':
    ensure       => present,
    source       => 'puppet:///modules/profile/apps/cd4pe/cd4pe-artifactory-data_s3.tar.gz',
    path         => '/tmp/bootstrap-cd4pe-artifactory-data_s3.tar.gz',
    extract_path => '/var/lib/docker/volumes/data_s3/_data',
    creates      => '/var/lib/docker/volumes/data_s3/_data/etc',
    extract      => true,
    cleanup      => true,
    require      => Docker_volume['data_s3'],
    before       => Docker::Run['cd4pe-artifactory'],
  }

  docker::run { 'cd4pe-artifactory':
    image   => 'docker.bintray.io/jfrog/artifactory-oss:5.8.3',
    net     => 'cd4pe-network',
    ports   => ['8081:8081'],
    volumes => ['data_s3:/var/opt/jfrog/artifactory'],
  }

  docker::run { 'cd4pe':
    image   => "${cd4pe_image}:latest",
    net     => 'cd4pe-network',
    ports   => ['8080:8080', '8000:8000', '7000:7000'],
    volumes => [
      'cd4pe-mysql:/var/lib/mysql',
      '/etc/hosts:/etc/hosts',
    ],
    env     => [
      'DB_ENDPOINT=mysql://cd4pe-mysql:3306/cd4pe',
      'DB_USER=cd4pe',
      'DB_PASS=puppetlabs',
      'DUMP_URI=dump://localhost:7000',
      'PFI_SECRET_KEY=5pM51Fu502mkPN3eKrHbvg==',
    ],
  }
}
