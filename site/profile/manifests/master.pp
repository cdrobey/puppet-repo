# master
#
# Install and configure base puppet master profile.
#
# @summary  This profiles opens the required firewall ports for the PE master server
#           communicate.
#
# @param    none
#
# @example
#   include profile::master or assign in PE classifier
# == Class: profile::master
class profile::master
{
  firewall { '200 allow puppet access':
    dport  => [80, 443, 4433, 8081, 8140, 8142, 8143, 8170, 61613],
    proto  => tcp,
    action =>  accept,
  }
}
