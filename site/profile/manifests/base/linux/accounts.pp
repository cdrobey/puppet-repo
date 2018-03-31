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
  Hash $users,
  ) {
  $users.each | $users_name, $users_data | {
    accounts::user { $users_name:
      ensure        => $users_data['ensure'],
      comment       => $users_data['comment'],
      groups        => $users_data['groups'],
      purge_sshkeys => $users_data['purge_sshkeys'],
      sshkeys       => $users_data['sshkeys'],
      password      => $users_data['password'],
    }
  }
}
