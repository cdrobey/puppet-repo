# == Class: profile::base::motd
class profile::base::motd ( $message, ) {
  # Set Message of the Day
  class { '::motd':
    content => $message,
  }
}
