# security
#
# Install and configure base security profile.
#
# @summary  This profiles aggregates all profiles needed for a baseline security configuration
#           of a security server or desktop.
#
# @param    none
#
# @example
#   include profile::linux::security or assign in PE classifier
# == Class: profile::linux::security
class profile::linux::security {
  include profile::linux::security::fw
}
