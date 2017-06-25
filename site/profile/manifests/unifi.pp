# == Class: profile::docker
class profile::unifi
{
  file {
    default:
      mode   => '0777',
      owner  => 'root',
      group  => 'root',
  }
  firewall { '200 allow unifi access':
    dport  => [80, 443, 8080, 8443, 8843, 8880, 3478, 6789, 10001],
    proto  => tcp,
    action =>  accept,
  }

  file { '/unifi':
    ensure => directory,
  }
  file { '/unifi/log':
    ensure  => directory,
  }
  file { '/unifi/lib':
    ensure => directory,
  }
}
