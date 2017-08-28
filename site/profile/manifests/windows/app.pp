# == Class: profile::windows::app
class profile::windows::app (
  $version,
  $reboot,
  $packages,
) {
  include dotnet
  include chocolatey

  if $reboot {
    reboot { 'Finalize .NET installation': }
    $notify = Reboot['Finalize .NET installation']
  }
  else {
    $notify = undef
  }

  [$version].flatten.each |$ver| {
    dotnet { ".NET Framework ${ver}":
      ensure  => present,
      version => $ver,
    }
  }

  Package { provider => chocolatey, }

  package { '7zip':
    ensure => present,
  }
  #each ($packages) | $name, $package | {
  #  package { $name:
  #    ensure => $package['ensure'],
  #  }
  #}
}
