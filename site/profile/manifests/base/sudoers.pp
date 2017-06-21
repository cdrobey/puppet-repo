# == Class: profile::base::sudoers
class profile::base::sudoers (
  $purge,
  $config_file_replace,
  $includedirsudoers,
  $configs,
) {

  class { 'sudo':
    purge               => $purge,
    config_file_replace => $config_file_replace,
    includedirsudoers   => $includedirsudoers,
    conf => {
      'ensure' => $configs::ensure_packages,
    }
  }
}
