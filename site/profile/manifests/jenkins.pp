class profile::jenkins (
  $plugs,
) {
  class { 'jenkins':
    version            => 'latest',
    lts                => false,
    configure_firewall => true,
  }

  class { 'jenkins::master':
  }

  $plugs.each | $plugin_name, $plugin_data | {
      jenkins::plugin { $plugin_name: }
  }
}
