# apprc
#
# Install and configure rc script for the defined application with startup validation.
#
# @summary  This class creates a mechanism to manage rc scripts for applications on RHEL/Centos7
#           system.  The script includes the capability to add a post-exec test validationn script
#           to ensure the health of the application after startup.
#
# @param apps [Hash] Hash table that maps an application, validate, and start and stop procedures.
#
# @example
#   include apprc
# == Class: role::windows
class role::windows {
  include profile::windows
}
