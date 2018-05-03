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
  String $installurl = 'https://s3.amazonaws.com/jumpcloud-windows-agent/production/JumpCloudInstaller.exe',
  String $installuuid = '5ae9d5a0f9f52a0e29ad3a28',
){
  file { 'C:\\Install':
    ensure => directory
  }

  -> remote_file { 'C:\\Install\\JumpCloudInstaller.exe':
    ensure => present,
    source => $installurl,
  }

  -> package { 'JumpCloud v1.0':
    ensure          => '1.0',
    source          => 'C:\\JumpCloudInstaller.exe',
    install_options => ["-k ${installuuid}", '/VERYSILENT', '/NORESTART']
  }

  -> service { 'jumpcloud-agent':
    ensure => 'running',
    enable => true,
  }
}
