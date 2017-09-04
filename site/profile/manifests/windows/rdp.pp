# == Class: profile::windows::rdp
class profile::windows::rdp (
  $enable,
  $nla_enable
  ){
  class { 'rdp':
    rdp_enable     => $enable,
    rdp_nla_enable => $nla_enable,
  }
}
