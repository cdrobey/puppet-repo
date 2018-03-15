# test
#
# Install and configure canary test profile.
#
# @summary  This role delivers a test configuration for checking different profiles.
#
# @param    none
#
# @example
#   include role::test or assign in PE classifier
# == Class: role::test
class role::test {
  include profile::base
  include profile::os::monitor
}
