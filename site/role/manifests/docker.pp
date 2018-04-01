# docker
#
# Install and configure canary docker profile.
#
# @summary  This role delivers a docker configuration for checking different profiles.
#
# @param    none
#
# @example
#   include role::docker or assign in PE classifier
# == Class: role::docker
class role::docker {
  include profile::base
}
