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

  # Purge all local accounts except permanent administrative accounts.
  purge { 'user':
    unless      => [
      [ 'name', '==', 'Administrator' ],
      [ 'name', '==', 'admin' ],
      [ 'name', '==', 'guest' ],
    ]
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
