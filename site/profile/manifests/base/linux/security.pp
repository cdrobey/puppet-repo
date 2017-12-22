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
#   include profile::base::linux::security or assign in PE classifier
# == Class: profile::base::linux::security
class profile::base::linux::security {
  include profile::base::linux::security::fw
}
