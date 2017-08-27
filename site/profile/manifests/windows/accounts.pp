# == Class: profile::windows::accounts
class profile::windows::accounts (
  $users,
) {
  each ($users) | $name, $user | {
    #notify {"array element : \"${user}\"": }

    user { $name:
      ensure     => present,
      groups     => $user['group'],
      comment    => $user['comment'],
      managehome => $user['managehome'],
      password   => $user['password'],
    }
  }
}
