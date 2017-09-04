# == Class: role::print
class role::print {
  include profile::linux
  include profile::print
}
