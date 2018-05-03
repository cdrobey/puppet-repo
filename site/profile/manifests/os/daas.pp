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

  #-> dsc_package { 'JumpCloud v1.0':
    #dsc_ensure    => 'present',
    #dsc_name      => 'JumpCloud v1.0',
    #dsc_productid => '96542816-DAD1-4D02-8363-CA4121E5CAE7',
    #dsc_path      => 'C:\\JumpCloudInstaller.exe',
  # dsc_arguments => '-k 5ae9d5a0f9f52a0e29ad3a28 /VERYSILENT /NORESTART',
  #}


  -> package { 'JumpCloud v1.0':
    ensure          => installed,
    source          => 'C:\\JumpCloudInstaller.exe',
    install_options => ['-k 5ae9d5a0f9f52a0e29ad3a28', '/VERYSILENT', '/NORESTART']
  }

  -> service { 'JumpCloud v1.0':
    ensure => 'running',
    enable => true,
  }
}
