# == Class: profile::windows::accounts
class profile::windows::accounts (
  $users,
) {
  # Permanent Account for Administrative Access
  user { 'admin':
    ensure     => present,
    groups     => ['Administrators'],
    comment    => 'Local Administrators',
    managehome => yes,
    password   => 'T3st!Passw0rd',
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
