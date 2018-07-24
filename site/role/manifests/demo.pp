# demo
#
# Install and configure demo system profiles for testting.
#
# @summary  This role delivers a demo configuration for checking different profiles in a development
#   environment.
#
# @param    none
#
# @example
#   include role::demo or assign in PE classifier
# == Class: role::demo
class role::demo {
  include profile::base
}
