# jenkins
#
# Install and configure base jenkins profile to setup a workflow server.
#
# @summary  This profile builds a jenkins server to support pipeline integration with PE.  The base
#           configuration uses a JenkinsFile to create a five stage pipeline for automated demo
#           of classified puppet code.
#
# @param    plugs - provides a hashed list of plugins to automatically install in the jenkins server.
#
# @example
#   include profile::apps::jenkins or assign in PE classifier
# == Class: profile::apps::jenkins
class profile::apps::jenkins (
  $plugs,
) {
  class { 'jenkins':
    version            => 'latest',
    lts                => false,
    configure_firewall => true,
  }

  class { 'jenkins::master':
  }

  jenkins::user { 'admin':
    email    => 'jdoe@example.com',
    password => 'puppetlabs',
  }

  $plugs.each | $plugin_name, $plugin_data | {
      jenkins::plugin { $plugin_name:
        version => $plugin_data['version']
      }
  }
  ensure_packages(['puppet-lint'], {'ensure' => 'present', 'provider' =>  'puppet_gem'})
}
