# monitor
#
# Install and configure telegraf for system managment.
#
# @summary  This profiles opens the required firewall ports for the telegraph monitor server
#           communicate.
#
# @param    none
#
# @example
#   include profile::os::monitor or assign in PE classifier
# == Class: profile::os::monitor
class profile::os::monitor (
  $influxdburi,
  $influxdbname
){
  firewall { '200 allow tcp monitorer access':
    dport  => [80, 443, 631, 515, 5353],
    proto  => tcp,
    action =>  accept,
  }
  class { 'telegraf':
    hostname => $facts['hostname'],
    outputs  => {
      'influxdb' => {
        'urls'     => [ $influxdburi, ],
        'database' => $influxdbname,
      }
    },
    inputs   => {
      'cpu'    => {},
      'mem'    => {},
      'io'     => {},
      'net'    => {},
      'disk'   => {},
      'swap'   => {},
      'system' => {},
    }
  }
}
