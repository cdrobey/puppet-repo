# == Class: profile::master::nodemanager
class profile::master::nodemanager {
  package { 'puppetclassify':
    ensure   => present,
    provider => puppet_gem,
  }

  Node_group {
    require => Package['puppetclassify'],
  }

  node_group { 'PE Master':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'PE Infrastructure',
    rule                 => ['or', ['=', 'name', $::clientcert]],
    classes              => {
      'role::master'                                     => {},
      'pe_repo'                                          => {},
      'pe_repo::platform::el_6_x86_64'                   => {},
      'pe_repo::platform::el_7_x86_64'                   => {},
      'pe_repo::platform::ubuntu_1404_amd64'             => {},
      'pe_repo::platform::windows_x86_64'                => {},
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
