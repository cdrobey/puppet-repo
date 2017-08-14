# == Class: profile::master::nodemanager
class profile::master::nodemanager {
  package { 'puppetclassify':
    ensure   => present,
    provider => puppet_gem,
  }

  package { 'puppetclassify':
    ensure   => present,
    provider => puppet_gem,
  }

  node_group { 'PE Master':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'PE Infrastructure',
    rule                 => ['or', ['=', 'name', $::clientcert]],
    classes              => {
      'role::master'                                     => {},
    },
  }

  node_group { 'Prod Linux':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and',
                            ['not', ['=', ['fact', 'name'], $::clientcert]],
                            ['=', ['fact', 'kernel'], 'linux'],
                            ],
    classes              => {
      'role::linux' => {},
    },
  }

  node_group { 'Prod Windows':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['=', ['fact', 'kernel'], 'windows']],
    classes              => {
      'role::windows' => {},
    },
  }
}
