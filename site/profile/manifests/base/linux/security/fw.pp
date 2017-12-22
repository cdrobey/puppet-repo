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
#   include profile::base::linux::security::fw or assign in PE classifier
# == Class: profile::base::linux::security::fw
class profile::base::linux::security::fw {

  class { 'firewall': }
  class { 'profile::base::linux::security::fwpre': }
  class { 'profile::base::linux::security::fwpost': }

  Firewall {
    before  => Class['profile::base::linux::security::fwpost'],
    require => Class['profile::base::linux::security::fwpre'],
  }
  resources { 'firewall':
    purge => true,
  }
}
