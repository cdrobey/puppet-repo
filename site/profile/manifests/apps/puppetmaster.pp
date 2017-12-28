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
#   include profile::puppetmaster::security or assign in PE classifier
# == Class: profile::puppetmaster::security
class profile::apps::puppetmaster
{
  firewall { '200 allow puppet access':
    dport  => [80, 443, 4433, 8081, 8140, 8142, 8143, 8170, 61613],
    proto  => tcp,
    action =>  accept,
  }

include pe_repo
include pe_repo::platform::el_7_x86_64
include pe_repo::platform::windows_x86_64
include puppet_enterprise
include puppet_enterprise::license
include puppet_enterprise::profile::agent
include puppet_enterprise::profile::amq::broker
include puppet_enterprise::profile::certificate_authority
include puppet_enterprise::profile::console
include puppet_enterprise::profile::master
include puppet_enterprise::profile::master::mcollective
include puppet_enterprise::profile::mcollective::agent
include puppet_enterprise::profile::mcollective::peadmin
include puppet_enterprise::profile::orchestrator
include puppet_enterprise::profile::puppetdb
}
