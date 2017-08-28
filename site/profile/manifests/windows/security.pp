# == Class: profile::windows::security
class profile::windows::security {
  # A stub for windows security baseline settings
  include profile::windows::security::cis
  include profile::windows::security::hipaa
}
