# iis
#
# Install and configure base iis web server.
#
# @summary  This role delivers a baseline configuration for a minimal secure configuration iis application.
#           The profiles secure a windows servers with a standard baseline configuration and provisions the 
#           iis web server with a series of features, and migrates the html doc home to a consolidated location.
#
# @param    none
#
# @example
#   include role::iis or assign in PE classifier
# == Class: role::iis
class role::iis {
  include profile::iis
  include profile::iis
}
