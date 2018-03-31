# motd
#
# Install and configure base motd profile.
#
# @summary  This profile configures the motd of a linux client.  Using parameters from hiera
#           the modules builds a motd for initial display after login.
#
# @param    content - motd to display
#
# @example
#   include profile::base::linux::motd or assign in PE classifier
# == Class: profile::base::linux::motd
class profile::base::linux::motd (
  String $content,
) {
  # Set Message of the Day
  class { 'motd':
    content => $content,
  }
}
