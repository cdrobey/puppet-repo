# base
#
# Install and configure base base profile.
#
# @summary  This role delivers a baseline configuration for a minimal secure linux and windows
#           configurations. It integrates a series of profiles built for baseline system compliance.
#
# @param    none
#
# @example
#   include role::linux or assign in PE classifier
# == Class: role::linux
class role::base {
  include profile::base
  include profile::os::monitor
}
