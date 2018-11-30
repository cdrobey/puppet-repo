# nut
#
# Install and configure nut ups monitoring profile.
#
# @summary  This profiles uses the nut module to configure an installation of a nut ups
#           monitoring.  The module loads the application and configures it to monitor an APC ups connected
#           via usb.
#
# @param    none
#
# @example
#   include profile::windows or assign in PE classifier
# == Class: profile::os::nut
class profile::os::nut (
){
  firewall { '200 allow nut access':
    dport  => [80, 443, 8080, 8443, 8843, 8880, 3478, 6789, 10001],
    proto  => tcp,
    action =>  accept,
  }
  firewall { '202 allow nut access':
    dport  => [ 3493 ],
    proto  => tcp,
    action =>  accept,
  }

  class { 'nut':
    listen => [
      {
        'address' => '0.0.0.0',
      },
    ],
  }
  nut::ups { 'ups':
    driver => 'usbhid-ups',
    port   => 'auto',
  }
  nut::user { 'monuser':
    password => 'secret',
    upsmon   => 'master',
  }
  nut::client::ups { 'ups@localhost':
    user     => 'monuser',
    password => 'secret',
  }
}
