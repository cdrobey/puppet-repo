# == Class: role::master
#
class role::master {
  # resources
  #All roles should include the base profile
  include 'profile::linux'
  include profile::master
}
