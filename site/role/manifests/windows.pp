# == Class: role::windows
class role::windows {
  include profile::windows::accounts
  include profile::windows::app
  include profile::windows::remote_access
}
