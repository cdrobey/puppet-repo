# == Class: profile::windows
class profile::windows {
  include profile::windows::accounts
  include profile::windows::app
  include profile::windows::remote_access
  include profile::windows::time
}
