# == Class: profile::windows::remote_access
class profile::windows::remote_access {
  class { 'rdp':
    rdp_enable     => true,
    rdp_nla_enable => false,
  }
}
