# clouddesktop
#
# Install and configure a clouddesktop OS.
#
# @summary  This role delivers a clouddesktop baseline configuration for a minimal secure linux and windows
#           configurations. It integrates a series of profiles built for baseline system compliance.
#
# @param    none
#
# @example
#   include role::clouddesktop or assign in PE classifier
# == Class: role::clouddesktop
class role::clouddesktop {
  include profile::base
  include profile::os::dfaas
}


