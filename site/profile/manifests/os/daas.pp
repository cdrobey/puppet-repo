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
  String $installuuid = '53dbf0a428951c7d4e737c7e06886a2c4b4a135b',
){

  reboot { 'jc_reboot':
    apply => finished,
  }

  file { 'C:\\Install':
    ensure => directory
  }

  -> remote_file { 'C:\\Install\\JumpCloudInstaller.exe':
    ensure => present,
    source => $installurl,
  }
  -> package { 'msvisualcplusplus2013-redist':
    provider => chocolatey,
  }

  -> package { 'JumpCloud v1.0':
    ensure          => '1.0',
    source          => 'C:\\Install\\JumpCloudInstaller.exe',
    install_options => [ '-k', $installuuid, '/VERYSILENT', '/NORESTART'],
    notify          => Reboot['jc_reboot'],
  }

  -> service { 'jumpcloud-agent':
    ensure => 'running',
    enable => true,
  }
}
