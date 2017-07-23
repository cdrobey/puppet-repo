# == Class: profile::linux::motd
class profile::linux::motd (
  $content,
) {
  # Set Message of the Day
  class { 'motd':
    content => $content,
  }
}
