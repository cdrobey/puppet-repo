# print
#
# Install and configure CUPS application print server
#
# @summary  This role delivers a cups print application server to perform network printer management.
#           CUPS provides a universal method to print across network and local attached print devices.
#           It includes a detail job management, scheduler, and controlled access.
#
# @param    none
#
# @example
#   include role::print or assign in PE classifier
# == Class: role::print
class role::print {
  include profile::base
  include profile::os::print
}
