# fwpost
#
# Install and configure base post firewall profile.
#
# @summary  This profile configures the firewall of a linux server after all application setup finishes.
#
# @param    none
#
# @example
#   include profile::base::linux::security::fwpost or assign in PE classifier
# == Class: profile::base::linux::security::fwpost
class profile::base::linux::security::fwpost {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
