# == Class: role::jenkins
class role::jenkins {
  include profile::linux
  include profile::jenkins
}
