# test
#
# Install and configure test system profiles for testting.
#
# @summary  This role delivers a test configuration for checking different profiles in a development
#   environment.
#
# @param    none
#
# @example
#   include role::test or assign in PE classifier
# == Class: role::test
class role::test {
  include profile::base
  include profile::os::docker
}
