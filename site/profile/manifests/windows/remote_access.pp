# == Class: profile::windows::remote_access
class profile::windows::remote_access {
  include local_security_policy

  local_security_policy { 'Allow log on through Remote Desktop Services':
    ensure       => present,
    policy_value => '1',
  }
}
