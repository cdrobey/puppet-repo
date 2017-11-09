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
#   include profile::windows or assign in PE classifier
# == Class: profile::windows
class profile::windows {
  include profile::windows::accounts
  include profile::windows::app
  include profile::windows::motd
  include profile::windows::rdp
  include profile::windows::time
  include profile::windows::security
}
