# == Class: profile::windows::rdp
class profile::windows::rdp (
  $enable,
  ){
  class { 'rdp':
    rdp_enable     => true,
    rdp_nla_enable => true,
  }
}
