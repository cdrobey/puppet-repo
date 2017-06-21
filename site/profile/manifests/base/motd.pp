# == Class: profile::base::motd
class profile::base::motd (
  $content,
) {
  # Set Message of the Day
  class { 'motd':
    content => $content,
  }
}
