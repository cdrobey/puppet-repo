# == Class: profile::windows::app
class profile::windows::app (
  $packages,
) {
  include profile::windows::app::dotnet
  include profile::windows::app::chocolately


  notify { "Answer is: ${packages}" }


  # ($packages) | $name, $package | {
  #  package { $name:
  #    ensure          => $package['ensure'],
  #    install_options => $package['install_options']
  #  }
  }
}
