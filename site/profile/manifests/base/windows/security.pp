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
#   include profile::base::windows::security or assign in PE classifier
# == Class: profile::base::windows::security
class profile::base::windows::security {
  include profile::base::windows::security::update
}
