# == Class: role::base
class role::windows {
  # resources
  #All roles should include the base profile
  include profile::windows::dotnet
  include profile::windows::chocolatey
  include profile::windows::baseline
}
