# == Class: role::docker
#
class role::unifi {
  # resources
  #All roles should include the base profile
  include profile::linux
  include profile::unifi
}
