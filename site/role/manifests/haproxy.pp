# haproxy
#
# Install and configure haproxy load balancer server
#
# @summary  This role delivers a management load balanced to proxy web services.  The role
#           builds a haproxy load balancer and uses hiera to configure the various paths for URLs.
#
# @param    none
#
# @example
#   include role::haproxy or assign in PE classifier
# == Class: role::haproxy
class role::haproxy {
  include profile::base
  include profile::os::monitor
  include profile::apps::haproxy
}
