# == Class: profile::windows::rdp
class profile::windows::rdp (
  $enable,
  ){
  class { 'rdp':
    rdp_enable     => $enable,
    rdp_nla_enable => true,
  }
}
