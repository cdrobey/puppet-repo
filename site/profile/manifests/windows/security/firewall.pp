# == Class: profile::windows:;firewall
class profile::windows::security::firewall {

    class {'windows_firewall':
        ensure => 'started',
    }
    windows_firewall::exception { 'pxp':
        ensure       => present,
        direction    => 'in',
        action       => 'Allow',
        enabled      => 'yes',
        protocol     => 'TCP',
        local_port   => '8140',
        remote_port  => 'any',
        display_name => 'Puppet Agent Management Port',
        description  => 'Inbound rule for Puppet Management. [TCP 8140]',
    }
}