# dfaas
#
# Install and configure jump cloud Directory and Google Backup and Sync.
#
# @summary  This profiles installs software used for servicing accounts and file
#           replication/sync.
#
# @param    gsyncinstallurl - URL of Google Backup and Sync installation location
#           jcinstallurl - URL of JumpCloudfile installation location
#           jcinstalluuid - UUID of system provided by Jumploud
#
# @example
#   include profile::os::dfaas or assign in PE classifier
# == Class: profile::os::dfaas
class profile::os::dfaas (
  String $gsyncinstallurl = 'https://dl.google.com/drive/gsync_enterprise64.msi',
  String $jcinstallurl = 'https://s3.amazonaws.com/jumpcloud-windows-agent/production/JumpCloudInstaller.exe',
  String $jcinstalluuid = '53dbf0a428951c7d4e737c7e06886a2c4b4a135b',
){

  reboot { 'dfaas_reboot':
    apply => finished,
  }

  file { 'dfaas_install':
    ensure => directory,
    path   => 'C:\\Install',
  }

  remote_file { 'C:\\Install\\JumpCloudInstaller.exe':
    ensure  => present,
    source  => $jcinstallurl,
    require => File['dfaas_install'],
  }

  -> package { 'JumpCloud v0.10.50':
    ensure          => '0.10.50',
    source          => 'C:\\Install\\JumpCloudInstaller.exe',
    install_options => [ '-k', $jcinstalluuid, '/SUPPRESSMSGBOXES', '/VERYSILENT', '/NORESTART'],
    notify          => Reboot['dfaas_reboot'],
  }

  -> service { 'jumpcloud-agent':
    ensure => 'running',
    enable => true,
  }

  remote_file { 'C:\\Install\\gsync_enterprise64.msi':
    ensure  => present,
    source  => $gsyncinstallurl,
    require => File['dfaas_install'],
  }

  -> package { 'Backup and Sync from Google':
    ensure => installed,
    source => 'C:\\Install\\gsync_enterprise64.msi',
  }
}
