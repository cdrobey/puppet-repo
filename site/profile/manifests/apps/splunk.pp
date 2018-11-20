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
    firewall { '300 allow splunk web access':
        dport  => [ 8000 ],
        proto  => tcp,
        action =>  accept,
    }
    firewall { '301 allow splunkd access':
        dport  => [ 8089 ],
        proto  => tcp,
        action =>  accept,
    }
    firewall { '302 allow logging access':
        dport  => [ 9997 ],
        proto  => tcp,
        action =>  accept,
    }
    firewall { '303 allow splunk pfSense access':
        dport  => [ 5442 ],
        proto  => udp,
        action =>  accept,
    }
    firewall { '304 allow splunk netflow access':
        dport  => [ 9995 ],
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
