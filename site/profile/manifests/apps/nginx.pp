# nginx
#
# Use nginx modules to setup a load balancer/reverse proxy.
#
# @summary  This profile installs a nginx loadbalancer/reverse proxy to provide connection management.
#           A list of applications and ports may be specified in hiera files.
#
# @param    listeners - a hased list of application using the service
#
# @example
#   include profile::apps::nginx or assign in PE classifier
# == Class: profile::apps::nginx
# test2 comment
class profile::apps::nginx (
  #Hash $proxylist,
){

  firewall { '300 allow communication to https':
    dport  => [ 80, 443 ],
    proto  => tcp,
    action =>  accept,
  }

  class { 'openssl':
    package_ensure         => latest,
    ca_certificates_ensure => latest,
  }

  openssl::certificate::x509 { 'familyroberson.com':
    ensure       => present,
    country      => 'US',
    organization => 'familyroberson.com',
    commonname   => 'local.familyroberson.com',
    state        => 'CO',
    locality     => 'Centennial',
    unit         => 'FamilyRoberson',
    altnames     => ['unifi.familyroberson.com', 'portainer.familyroberson.com', 'puppet.familyroberson.com'],
    email        => 'chris@familyroberson.com',
    days         => 3456,
  }
  class {'nginx':}

  nginx::resource::server { 'unifi.familyroberson.com':
    server_name       => [ 'unifi.familyroberson.com' ],
    proxy             => 'https://docker-p01.local.familyroberson.com:8443',
    ssl               => true,
    ssl_redirect      => true,
    ssl_key           => '/etc/ssl/certs/familyroberson.com.key',
    ssl_cert          => '/etc/ssl/certs//familyroberson.com.crt',
    server_cfg_append => {
      'ssl_verify_client' => 'off',
      'ssl_verify_depth'  => 2,
    },
  }

  nginx::resource::server { 'portainer.familyroberson.com':
    server_name       => [ 'portainer.familyroberson.com' ],
    proxy             => 'http://docker-p01.local.familyroberson.com:9000',
    ssl               => true,
    ssl_redirect      => true,
    ssl_key           => '/etc/ssl/certs/familyroberson.com.key',
    ssl_cert          => '/etc/ssl/certs//familyroberson.com.crt',
    server_cfg_append => {
      'ssl_verify_client' => 'off',
      'ssl_verify_depth'  => 2,
    },
  }

  nginx::resource::server { 'puppet.familyroberson.com':
    server_name       => [ 'puppet.familyroberson.com' ],
    proxy             => 'https://puppet-p01.local.familyroberson.com',
    ssl               => true,
    ssl_redirect      => true,
    ssl_key           => '/etc/ssl/certs/familyroberson.com.key',
    ssl_cert          => '/etc/ssl/certs//familyroberson.com.crt',
    server_cfg_append => {
      'ssl_verify_client' => 'off',
      'ssl_verify_depth'  => 2,
    },
  }
}

