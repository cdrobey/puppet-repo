# tenable
#
# Use tenable for network scanning.
#
# @summary  This role configures a tenable nessus system.
#
# @param    none
#
# @example
#   include role::tenable or assign in PE classifier
# == Class: profile::apps::tenable
class role::tenable (
){
  include profile::base
  include profile::os::monitor
  include profile::apps::tenable
}
