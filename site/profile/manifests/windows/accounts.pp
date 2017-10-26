# == Class: profile::windows::accounts
class profile::windows::accounts (
  $users,
) {
  # Permanent Account for Administrative Access
  user { 'deploy':
    ensure     => present,
    groups     => ['Administrators'],
    comment    => 'Local Administrators',
    managehome => yes,
    password   => 'FamilyR0bersonL@b',
  }

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
