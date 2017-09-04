# == Class: profile::windows::rdp
class profile::windows::rdp (
  $enable,
  ){
  class { 'rdp':
    rdp_enable     => true,
  }
}
