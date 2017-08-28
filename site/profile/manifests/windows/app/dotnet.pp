# == Class: profile::windows::app::dotnet
class profile::windows::app::dotnet (
  String  $ensure,
  String  $version,
  Boolean $reboot,
) {
    if $reboot {
      reboot { 'Finalize .NET installation': }
      $notify = Reboot['Finalize .NET installation']
    }
    else {
      $notify = undef
    }

    [$version].flatten.each |$ver| {
      dotnet { ".NET Framework ${ver}":
        ensure  => $ensure,
        version => $ver,
        notify  => $notify,
      }
    }
}
