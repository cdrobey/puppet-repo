# fw
#
# Install and configure base firewall profile.
#
# @summary  This profile configures the firewall of a linux server after purging the existing firewall
#           configuration.  The firewall configures the ports using a pre/post and application firewall class.
#
# @param    none
#
# @example
#   include profile::linux::security::fw or assign in PE classifier
# == Class: profile::linux::security::fw
class profile::linux::security::fw {

  class { 'firewall': }
  class { 'profile::linux::security::fwpre': }
  class { 'profile::linux::security::fwpost': }

  Firewall {
    before  => Class['profile::linux::security::fwpost'],
    require => Class['profile::linux::security::fwpre'],
  }
  resources { 'firewall':
    purge => true,
  }
}
