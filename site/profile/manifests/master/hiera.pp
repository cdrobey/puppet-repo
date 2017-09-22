# == Class: profile::master::hiera
class profile::master::hiera {
  class { 'hiera':
    datadir_manage => false,
    datadir        => '/etc/puppetlabs/code/environments/%{environment}/hieradata',
    eyaml          => true,
    hierarchy      => [
      'nodes/%{clientcert}',
      'environment/%{environment}',
      'common',
    ],
  }

  Service <| title == 'pe-puppetserver' |> {
    subscribe => Class['hiera'],
  }
}
