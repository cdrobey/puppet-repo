# canary
#
# Install and configure canary system profiles for testting.
#
# @summary  This role delivers a canary configuration for checking different profiles in a development
#   environment.
#
# @param    none
#
# @example
#   include role::canary or assign in PE classifier
# == Class: role::canary
class role::canary {
  include profile::base
  include profile::apps::haproxy
  include profile::apps::unifi
  include profile::apps::monitormaster
}
