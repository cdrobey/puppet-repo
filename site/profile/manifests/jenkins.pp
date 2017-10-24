class profile::jenkins (
  $plugins,
) {
  include git

  class { 'jenkins':
    version            => 'latest',
    lts                => false,
    configure_firewall => true,
  }

  class { 'jenkins::master':
    version => '2.2',
  }
  class { 'jenkins::plugins':
    plugin_hash => $plugins,
  }
}
