# faas
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
#   include profile::os::faas or assign in PE classifier
# == Class: profile::os::faas
class profile::os::faas (
  String $installurl = 'https://dl.google.com/drive/gsync_enterprise64.msi',
){
  file { 'GsyncInstall':
    ensure => directory,
    path   => 'C:\\Install',
  }

  -> remote_file { 'C:\\Install\\gsync_enterprise64.exe':
    ensure => present,
    source => $installurl,
  }

  -> package { 'Google Backup and Sync':
    ensure          => 'installed',
    source          => 'C:\\Install\\gsync_enterprise64.exe',
    install_options => [ '/SUPPRESSMSGBOXES', '/VERYSILENT', '/NORESTART'],
  }
}
