# fwpost
#
# Install and configure base post firewall profile.
#
# @summary  This profile configures the firewall of a linux server after all application setup finishes.
#
# @param    none
#
# @example
#   include profile::linux::security::fwpost or assign in PE classifier
# == Class: profile::linux::security::fwpost
class profile::linux::security::fwpost {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
