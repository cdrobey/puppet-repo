# == Class: profile::windows::accounts
class profile::windows::accounts (
  $users,
) {
  each ($users) | $name, $user | {
    notify {"array element : \"${user}\"": }
  }
}
