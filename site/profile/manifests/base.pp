# base
#
# Install and configure base profile.
#
# @summary  This profiles aggregates all profiles needed for a baseline configuration
#           of all servers or desktops.
#
# @param    none
#
# @example
#   include profile::base or assign in PE classifier
# == Class: profile::base
class profile::base
{
  case $facts['os']['family'] {
    'redhat': { include profile::base::linux }
    'debian': { include profile::base::linux }
    'windows': { include profile::base::windows }
    default: { notify { "No base profile for ${facts['os']['family']}": } }
  }
}
