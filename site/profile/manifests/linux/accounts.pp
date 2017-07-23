# == Class: profile::linux::accounts
class profile::linux::accounts (
  $users,
  $user_defaults,
  ) {
  class { 'accounts':
    user_defaults => $user_defaults,
    users         => $users,
  }
}
