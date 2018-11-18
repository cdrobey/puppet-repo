# splunk
#
# Install and configure splunk system for managing centralized log file monitoring and visualization.
#
# @summary  This role delivers a splunk configuration for consolidating logging across the homelab.
# @param    none
#
# @example
#   include role::splunk or assign in PE classifier
# == Class: role::splunk
class role::splunk {
  include profile::base
  include profile::os::monitor
  include profile::apps::splunk
}
