# graylog
#
# Install and configure graylog system for managing centralized log file monitoring and visualization.
#
# @summary  This role delivers a graylog configuration for consolidating logging across the homelab and 
#           provides a method to inject visulation of logfiles into Grafana.
#
# @param    none
#
# @example
#   include role::graylog or assign in PE classifier
# == Class: role::graylog
class role::graylog {
  include profile::base
  include profile::os::monitor
}
