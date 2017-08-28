# == Class: profile::windows::app
class profile::windows::app (
  $packages,
) {
  #include profile::windows::app::dotnet
  #include profile::windows::app::chocolately

  Package { provider => chocolatey, }
  include chocolatey
  package { '7zip':
    ensure => present,
  }
  #each ($packages) | $name, $package | {
  #  package { $name:
  #    ensure          => $package['ensure'],
  #    install_options => $package['install_options'],
  #    source          => "https://chocolatey.org/packages",
  #  }
  #}
}
