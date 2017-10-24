class profile::jenkins (
  $plugins,
) {
  class { 'jenkins':
    version            => 'latest',
    lts                => false,
    configure_firewall => true,
  }

  class { 'jenkins::master':
    version => '2.2',
  }
  $plugins.each | $plugin_name, $plugin_data | {
    jenkins::plugin { $plugin_name:
      version => $plugin_data['version'],
      source  => $plugin_data['source'],
    }
  }
}
