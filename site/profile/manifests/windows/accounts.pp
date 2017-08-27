# == Class: profile::windows::accounts
class profile::windows::accounts (
  $users,
) {
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
