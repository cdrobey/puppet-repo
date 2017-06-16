# == Class: profile::base::sudoers
class profile::base::sudoers {

  $sudoers_purge = hiera('profile::base::sudoers::purge')
  $sudoers_false = hiera('profile::base::sudoers::config_file_replace')
  $sudoers_true = hiera('profile::base::sudoers::includedirsudoers')
  $sudoers_sudo_configs = hiera_array('profile::base::sudoers::sudo::configs')

  class { 'sudo':
    purge               => $sudoers_purge,
    config_file_replace => $sudoers_false,
    includedirsudoers   => $sudoers_true,
  }

  class { 'sudo::configs':
    configs => $sudoers_sudo_configs,
  }
}
