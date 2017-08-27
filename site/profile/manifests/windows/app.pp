# == Class: profile::windows::app
class profile::windows::app (
  $packages
) {
  include profile::windows::app::dotnet
  include profile::windows::app::chocolately

  Package {
    ensure   => installed,
    provider => chocolatey,
  }
  each ($packages) | $name, $package | {
    package { $package }
  }
}
