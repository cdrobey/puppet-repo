# == Class: role::master
class role::master {
  include 'profile::linux'
  include 'profile::master'
}
