# update
#
# Install and configure base update profile.
#
# @summary  This profile configures windows update to ensure patch hardening.
#
# @param    none
#
# @example
#   include profile::base::windows::security::update or assign in PE classifier
# == Class: profile::base::windows::security::update
class profile::base::windows::security::update (
  String $install_day = '4',
  String $install_time = '4',
) {
  class { 'windows_autoupdate':,
    au_options             => '4',
    scheduled_install_day  => $install_day,
    scheduled_install_time => $install_time,
  }
}
