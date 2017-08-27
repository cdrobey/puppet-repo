# == Class: role::windows
class role::windows {
  include profile::windows::accounts
  include profile::windows::dotnet
  include profile::windows::chocolatey
  include profile::windows::baseline
}
