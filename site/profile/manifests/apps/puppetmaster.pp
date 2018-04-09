# puppetmaster
#
# Install and configure base puppet puppetmaster profile.
#
# @summary  This profiles opens the required firewall ports for the PE puppetmaster server
#           communicate.
#
# @param    none
#
# @example
#   include profile::puppetmaster or assign in PE classifier
# == Class: profile::puppetmaster
class profile::apps::puppetmaster
{
  firewall { '200 allow puppet access':
    dport  => [80, 443, 4433, 8081, 8140, 8142, 8143, 8170, 61613],
    proto  => tcp,
    action =>  accept,
  }
}
