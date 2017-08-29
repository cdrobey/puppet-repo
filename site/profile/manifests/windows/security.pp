# == Class: profile::windows::security
class profile::windows::security {
  include profile::windows::security::cis
  include profile::windows::security::hipaa
}
