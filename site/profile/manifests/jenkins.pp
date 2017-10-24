class profile::jenkins {
  class { 'jenkins':
    version            => 'latest',
    lts                => false,
    configure_firewall => true,
  }

  class { 'jenkins::master':
    version => '2.2',

  }
}
