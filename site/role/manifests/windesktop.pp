# windows
#
# Install and configure base windows profile.
#
# @summary  This role delivers a baseline configuration for a minimal secure configuration.
#           It integrates a series of profiles built for base windows setup.
#
# @param    none
#
# @example
#   include role::windows or assign in PE classifier
# == Class: role::windows
class role::windesktop {
  include profile::windesktop
}
