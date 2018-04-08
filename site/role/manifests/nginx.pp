# nginx
#
# Install and configure nginx load balancer/reverse proxy server
#
# @summary  This role delivers a management load balanced/reverse proxy for  web services.  The role
#           builds a nginx load balancer and uses hiera to configure the various paths for URLs.
#
# @param    none
#
# @example
#   include role::nginx or assign in PE classifier
# == Class: role::nginx
class role::nginx {
  include profile::base
  include profile::os::monitor
  include profile::apps::nginx
}
