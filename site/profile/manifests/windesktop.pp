# windesktop
#
# Install and configure base windows desktop profile.
#
# @summary  This profiles aggregates all profiles needed for a baseline security configuration
#           of a windows server or desktop.
#
# @param    none
#
# @example
#   include profile::windesktop or assign in PE classifier
# == Class: profile::windesktop
class profile::windesktop {
  include profile::windows::app
  include profile::windows::motd
  include profile::windows::rdp
  include profile::windows::time
}
