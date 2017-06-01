# == Class: role::base
#
class role::linux {
  # resources
  #All roles should include the base profile
  include profile::base
}
