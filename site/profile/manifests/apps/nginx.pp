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
# test comment
class profile::apps::nginx (
  #Hash $proxylist,
){

  firewall { '300 allow communication to https':
    dport  => [ 443 ],
    proto  => tcp,
    action =>  accept,
  }
  nginx::resource::server { 'unifi.familyroberson.com':
    server_name       => [ 'unifi.familyroberson.com' ],
    proxy             => 'https://docker-p01.local.familyroberson.com:8443',
    ssl               => true,
    ssl_redirect      => true,
    ssl_key           => '/etc/letsencrypt/live/familyroberson.com/privkey.pem',
    ssl_cert          => '/etc/letsencrypt/live/familyroberson.com/fullchain.pem',
    server_cfg_append => {
      'ssl_verify_client' => 'off',
      'ssl_verify_depth'  => 1,
    },
  }
  class { 'letsencrypt':
    config => {
      unsafe_registration => true,
      server              => 'https://acme-staging.api.letsencrypt.org/directory',
    }
  }

  class { 'letsencrypt_nginx':
    firstrun_webroot => '/usr/share/nginx/html',
    servers          => {
      '*.familyroberson.com' => {},
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

