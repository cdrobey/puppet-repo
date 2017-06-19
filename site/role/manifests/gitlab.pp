# == Class: role::base
#
class role::base {
  # resources
  #All roles should include the base profile
  include profile::base
  include profile::gitlab
}
