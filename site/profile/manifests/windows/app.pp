# == Class: profile::windows::app
class profile::windows::app (
  $packages
) {
  include profile::windows::app::dotnet
  include profile::windows::app::chocolately

  each ($packages) | $name, $package | {
    package { $package:
      ensure          => $name['ensure'],
      install_options => $name['install_options']}
  }
}
