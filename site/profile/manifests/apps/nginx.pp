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
    email        => 'chris@familyroberson.com',
    days         => 3456,
  }
  class {'nginx':}

  nginx::resource::server { 'test.familyroberson.com':
    server_name       => [ 'test.familyroberson.com' ],
    proxy             => 'https://docker-p01.local.familyroberson.com:8443',
    ssl               => true,
    ssl_redirect      => true,
    ssl_key           => '/etc/ssl/certs/familyroberson.com.key',
    ssl_cert          => '/etc/ssl/certs//familyroberson.com.crt',
    server_cfg_append => {
      'ssl_verify_client' => 'off',
      'ssl_verify_depth'  => 1,
    },
  }

  nginx::resource::server { 'test2.familyroberson.com':
    server_name       => [ 'test2.familyroberson.com' ],
    proxy             => 'https://puppet-p01.local.familyroberson.com',
    ssl               => true,
    ssl_redirect      => true,
    ssl_key           => '/etc/ssl/certs/familyroberson.com.key',
    ssl_cert          => '/etc/ssl/certs//familyroberson.com.crt',
    server_cfg_append => {
      'ssl_verify_client' => 'off',
      'ssl_verify_depth'  => 1,
    },
  }
}

  #$proxylist.each | $proxy_name, $proxy | {
  #  nginx::resource::server{ $proxy_name:
  #    server_name       => [ $proxy_name ],
  #    listen_port       => 443,
  #    ssl_port          => 443,
  #    ssl               => true,
  #    ssl_cert          => '/etc/ssl/public/familyroberson.crt',
  #     ssl_key           => '/etc/ssl/public/familyroberson.key',
  #     proxy             => $proxy['proxy'],
  #    server_cfg_append => {
  #      'ssl_verify_client' => 'off',
  #      'ssl_verify_depth'  => 1,
  #    },
  #  }
  #}

