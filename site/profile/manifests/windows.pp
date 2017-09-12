# == Class: profile::windows
class profile::windows {
  include profile::windows::accounts
  include profile::windows::app
  include profile::windows::motd
  include profile::windows::rdp
  include profile::windows::time
  include profile::windows::security
}
