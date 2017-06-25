# == Class: role::docker
#
class role::docker {
  # resources
  #All roles should include the base profile
  include profile::base
  include profile::docker
}
