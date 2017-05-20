# == Class: profile::base::accounts
class profile::base::accounts {
  user {'ubuntu':
    ensure  => 'present',
    comment => 'Default',
    home    => '/home/ubuntu',
  }

  class { 'accounts':
    ssh_keys       => hiera_hash('accounts::ssh_keys'),
    users          => hiera_hash('accounts::users'),
    usergroups     => hiera_hash('accounts::usergroups'),
    purge_ssh_keys => true,
  }
  accounts::account { 'foo': }

}
