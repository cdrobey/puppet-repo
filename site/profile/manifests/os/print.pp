# print
#
# Install and configure base print cups server profile.
#
# @summary  This profiles opens the required firewall ports for the CUPS print server
#           communicate.
#
# @param    none
#
# @example
#   include profile::os::print or assign in PE classifier
# == Class: profile::os::print
class profile::os::print {

  firewall { '200 allow tcp printer access':
    dport  => [80, 443, 631, 515, 5353],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '200 allow udp printer access':
    dport  => [631, 515, 5353],
    proto  => udp,
    action =>  accept,
  }
}
