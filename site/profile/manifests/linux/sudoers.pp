# == Class: profile::linux::sudoers
class profile::linux::sudoers (
  $purge,
  $config_file_replace,
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
