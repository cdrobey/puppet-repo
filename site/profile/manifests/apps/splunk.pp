# splunk
#
# Use splunk for monitoring and logging.
#
# @summary  This profile installs splunk enterprise and configures the base master system.
#
# @param    none
#
# @example
#   include profile::splunk or assign in PE classifier
# == Class: profile::apps::splunk
class profile::apps::splunk (
){
    firewall { '200 allow http/https access':
        dport  => [80, 443],
        proto  => tcp,
        action =>  accept,
    }

    class { 'splunk::params':
        version  => '7.2.0',
        build    => '8c86330ac18',
        src_root => 'https://download.splunk.com',
    }

    class { 'splunk':
        package_ensure => 'latest',
    }
}
