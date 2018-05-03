# daas
#
# Install and configure jump cloud Directory as a Service.
#
# @summary  This profiles installs directory as a service provider
#           JumpCloud on Windows.
#
# @param    installurl - URL of file installation location
#           systemuuid - UUID of system provided by Jumploud
#
# @example
#   include profile::os::daas or assign in PE classifier
# == Class: profile::os::daas
class profile::os::daas (
#  $installurl,
#  $systemuuid,
){
  remote_file { 'C:\\JumpCloudInstaller.exe':
    ensure => present,
    source => 'https://s3.amazonaws.com/jumpcloud-windows-agent/production/JumpCloudInstaller.exe',
  }
}
