# == Class: profile::base
class profile::coderepo {
  include 'profile::coderepo::fw'
  include 'profile::coderepo::gitlab'
}
