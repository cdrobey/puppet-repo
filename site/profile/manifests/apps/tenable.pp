# tenable
#
# Use tenable for network scanning.
#
# @summary  This profile installs tenable nessus and configures the base master system.
#
# @param    none
#
# @example
#   include profile::tenable or assign in PE classifier
# == Class: profile::apps::tenable
class profile::apps::tenable (
){
    firewall { '300 allow tenable web access':
        dport  => [ 8443 ],
        proto  => tcp,
        action =>  accept,
    }
}
