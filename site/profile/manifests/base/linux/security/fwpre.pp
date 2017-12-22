# fwpre
#
# Install and configure base pre firewall profile.
#
# @summary  This profile configures the firewall of a linux server before all application setup starts.
#
# @param    none
#
# @example
#   include profile::base::linux::security::fwpre or assign in PE classifier
# == Class: profile::base::linux::security::fwpre
class profile::base::linux::security::fwpre {
  Firewall {
    require => undef,
  }
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
  firewall { '002 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
}
