# == Class: role::base
#
class role::gitlab {
  # resources
  #All roles should include the base profile
  include profile::gitlab
}
