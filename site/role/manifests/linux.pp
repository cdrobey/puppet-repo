# linux
#
# Install and configure base linux profile.
#
# @summary  This role delivers a baseline configuration for a minimal secure linux configuration. It integrates 
#           a series of profiles built for base linux setup.
#
# @param    none
#
# @example
#   include role::linux or assign in PE classifier
# == Class: role::linux
class role::linux {
  include 'profile::linux'
}
