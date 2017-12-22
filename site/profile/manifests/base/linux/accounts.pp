# accounts
#
# Install and configure base accounts profile.
#
# @summary  This profile configures the system/service accounts.  A static set of services/administrative 
#           accounts are forced installed on every system.  A dynamic set of accounts build from a hiera
#           hash are loaded. 
#
# @param    users - hashed key-value pair of accounts
#           user_defaults - hashed key-value pair of base user default
#
# @example
#   include profile::base::linux::accounts or assign in PE classifier
# == Class: profile::base::linux::accounts
class profile::base::linux::accounts (
  $users,
  $user_defaults,
  ) {
  class { 'accounts':
    user_defaults => $user_defaults,
    users         => $users,
  }
}
