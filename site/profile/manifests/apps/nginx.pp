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
class profile::apps::nginx (
  String $virtualhost,
  Integer $virtualhostport,
  Hash $locations,
  Array $certdomains,
  String $certemail,
  Array $proxysetheaders,
){

  firewall { '300 allow communication to InfluxDB and Grafana':
    dport  => [80, 443],
    proto  => tcp,
    action =>  accept,
  }

  class { 'nginx': }

  class { 'letsencrypt':
    email          => $certemail,
    install_method => 'vcs',
    repo           => 'https://github.com/certbot/certbot.git',
  }

  letsencrypt::certonly { $certdomains:
    plugin               => 'nginx',
    manage_cron          => true,
    suppress_cron_output => true,
  }

  nginx::resource::server{ 'unifi.familyroberson.com':
    listen_port      => 443,
    ssl              => true,
    ssl_cert         => '/etc/letsencrypt/live/familyroberson.com/fullchain.pem',
    ssl_key          => '/etc/letsencrypt/live/familyroberson.com/privkey.pem',
    proxy            => 'https://co-u1604-unip01:8443/' ,
    proxy_set_header => $proxysetheaders,
  }
}
