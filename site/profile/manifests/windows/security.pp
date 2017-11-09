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
#   include profile::windows::security or assign in PE classifier
# == Class: profile::windows::security
class profile::windows::security {
  include profile::windows::security::cis
}
