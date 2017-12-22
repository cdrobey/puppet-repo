# apprc
#
# Install and configure base apprc demonstration server.
#
# @summary  This role delivers a baseline configuration for a minimal secure configuration.
#           It integrates a series of profiles designed to demo the apprc module.  The configuration applies
#           a baseline linux configuration and establishes a configuration for applying example rc scripts.
#
# @param    none
#
# @example
#   include role::apprc or assign in PE classifier
# == Class: role::apprc
class role::apprcdemo {
  include profile::base
  include profile::apps::apprc
}
