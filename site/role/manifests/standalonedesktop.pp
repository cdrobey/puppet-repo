# standalonedesktop
#
# Install and configure a standalonedesktop OS.
#
# @summary  This role delivers a standalonedesktop configuration for a windows desktop
#           configurations. It integrates a series of profiles built for baseline system compliance.
#
# @param    none
#
# @example
#   include role::standalonedesktop or assign in PE classifier
# == Class: role::standalonedesktop
class role::standalonedesktop {
  include profile::base
  include profile::os::monitor
}
