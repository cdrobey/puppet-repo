# accounts
#
# Install and configure base accounts profile.
#
# @summary  This profile configures the system/service accounts.  A static set of services/administrative 
#           accounts are forced installed on every system.  A dynamic set of accounts build from a hiera
#           hash are loaded. 
#
# @param    pacusers - hashed key-value pair of account information
#
# @example
#   include profile::base::windows::accounts or assign in PE classifier
# == Class: profile::base::windows::accounts
class profile::base::windows::accounts (
  Hash $users,
) {
  # Add all dynamic accounts
  each ($users) | $name, $user | {
    user { $name:
      ensure     => $user['ensure'],
      groups     => $user['groups'],
      comment    => $user['comment'],
      managehome => $user['managehome'],
      password   => $user['password'],
    }
  }
}
