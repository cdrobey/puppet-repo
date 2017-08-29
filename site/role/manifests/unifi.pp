# == Class: role::unifi
class role::unifi {
  include profile::linux
  include profile::unifi
}
