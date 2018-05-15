# desktop
#
# Install and configure a desktop OS.
#
# @summary  This role delivers a desktop baseline configuration for a minimal secure linux and windows
#           configurations. It integrates a series of profiles built for baseline system compliance.
#
# @param    none
#
# @example
#   include role::desktop or assign in PE classifier
# == Class: role::desktop
class role::desktop {
  include profile::base
  #include profile::os::monitor
  include profile::os::daas
  include profile::os::faas
}


