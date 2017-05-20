# == Class: profile::base::sudoers
class profile::base::sudoers {
  class { '::sudo':
    purge               => false,
    config_file_replace => false,
    includedirsudoers   => true,
  }
}
