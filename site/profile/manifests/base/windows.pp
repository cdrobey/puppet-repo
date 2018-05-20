# windows
#
# Install and configure base windows profile.
#
# @summary  This profiles aggregates all profiles needed for a baseline security configuration
#           of a windows server or desktop.
#
# @param    none
#
# @example
#   include profile::base::windows or assign in PE classifier
# == Class: profile::base::windows
class profile::base::windows {
  include profile::base::windows::accounts
  include profile::base::windows::app
  include profile::base::windows::motd
  include profile::base::windows::rdp
  include profile::base::windows::time
  include profile::base::windows::security

}
