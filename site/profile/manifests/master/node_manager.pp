# node_manager
#
# Install and configure base node_manager profile.
#
# @summary  This profile updates the puppet master classifier with a default set of base node groups.  At
#           bootstrap of a PE master the node_group template configures code manager and other services.
#
# @param    node
#
# @example
#   include profile::master::node_manager or assign in PE classifier
# == Class: profile::master::node_manager
class profile::master::node_manager {
  package { 'puppetclassify':
    ensure   => present,
    provider => puppet_gem,
  }

  Node_group {
    require => Package['puppetclassify'],
  }

  node_group { 'PE Package':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['or', ['=', 'name', $::clientcert]],
    classes              => {
      'puppet_enterprise::profile::agent' => {
        'package_inventory_enabled' => true,
      },
    },
  }
  node_group { 'PE Master':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'PE Infrastructure',
    rule                 => ['or', ['=', 'name', $::clientcert]],
    classes              => {
      'pe_repo'                                          => {},
      'pe_repo::platform::el_6_x86_64'                   => {},
      'pe_repo::platform::el_7_x86_64'                   => {},
      'pe_repo::platform::ubuntu_1404_amd64'             => {},
      'pe_repo::platform::windows_x86_64'                => {},
      'puppet_enterprise::profile::master'               => {
        'code_manager_auto_configure' => true,
        'r10k_remote'                 => 'https://github.com/cdrobey/puppet-repo',
        'r10k_private_key'            => '/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa' },
      'puppet_enterprise::profile::master::mcollective'  => {},
      'puppet_enterprise::profile::mcollective::peadmin' => {},
      'role::master'                                     => {},
    },
  }
}
