class profile::windows::dotnet (
  Enum['present', 'absent']
  $ensure = 'present',

  Variant[String, Array[String, 1]]
  $version = '4.0',

  Boolean
  $reboot = true,
) {

  include dotnet::params

  if $reboot {
    # Ensure that the system is rebooted after any .NET install/uninstall
    # activity.
    reboot { 'Finalize .NET installation': }
    $notify = Reboot['Finalize .NET installation']
  }
  else {
    $notify = undef
  }

  # For each version specified in the $version parameter, ensure that version
  # of .NET is present or absent (as specified by the user).
  [$version].flatten.each |$ver| {

    dotnet { ".NET Framework ${ver}":
      ensure      => $ensure,
      version     => $ver,
      notify      => $notify,
      package_dir => $package_dir,
    }
  }

}
