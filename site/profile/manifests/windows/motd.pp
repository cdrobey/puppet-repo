# motd
#
# Install and configure base motd profile.
#
# @summary  This profile configures the motd a window client.  Using parameters from hiera
#           the modules builds a motd for initial display prior to login.
#
# @param    content - motd to display
#
# @example
#   include profile::windows::motd or assign in PE classifier
# == Class: profile::windows::motd
class profile::windows::motd (
  $content,
) {
  registry_value { '32:HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption':
    ensure => present,
    type   => string,
    data   => 'Message of the day',
  }

  registry_value { '32:HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext':
    ensure => present,
    type   => string,
    data   => $content,
  }
}
