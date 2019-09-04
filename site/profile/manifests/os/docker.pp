# docker
#
# Install and configure docker for management of images.
#
# @summary  This profiles deployes the basic docker server setup.
#
# @example
#   include profile::os::docker or assign in PE classifier
# == Class: profile::os::docker
class profile::os::docker
{
  class { 'docker':
    version   => 'latest',
  }
}
