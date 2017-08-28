# == Class: role::windows
class role::windows {
  include profile::windows::accounts
  include profile::windows::app
  include profie::windows::remote_access
}
