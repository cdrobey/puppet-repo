# == Class: profile::base::accounts
class profile::base::accounts (
  $users,
  $user_defaults,
  ) {
  class { 'accounts:'
    user_defaults => $user_defaults,
    users         => $users,
  }
}
