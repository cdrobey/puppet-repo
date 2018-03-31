# sudoers
#
# Install and configure base sudoers profile.
#
# @summary  This profile configures the sudoer users and access privileges.  Using parameters from hiera
#           the modules configures the base list of users that are allowed system level access.
#
# @param    purge - boolean used to remove all sudoer configuration
#           config_file_replace - boolean used to wipe the configuration template for users
#           configs = hashed key-value pair defining the services and group access
#
# @example
#   include profile::base::linux::sudoers or assign in PE classifier
# == Class: profile::base::linux::sudoers
class profile::base::linux::sudoers (
  Boolean $purge,
  Boolean $config_file_replace,
  $configs,
) {

  class { 'sudo':
    purge               => $purge,
    config_file_replace => $config_file_replace,
  }
  each ($configs) | $name, $config | {
    sudo::conf { $name:
      * => $config
    }
  }
}
