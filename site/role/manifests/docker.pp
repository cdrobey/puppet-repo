# docker
#
# Install and configure docker system profiles for docker.
#
# @summary  This role delivers a docker configuration for incorporating the docker infrastructure
#           and loads the appropriate container configuration.
#
# @param    none
#
# @example
#   include role::docker or assign in PE classifier
# == Class: role::docker
class role::docker {
  include profile::base
  include profile::os::monitor
  include profile::apps::docker
}
