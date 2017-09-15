# == Class: role::iis
class role::iis {
  include profile::windows
  include profile::iis
}
