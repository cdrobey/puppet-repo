# == Class: role::linux
class role::print {
  include 'profile::linux'
  include 'profile::print'
}
