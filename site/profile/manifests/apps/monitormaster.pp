# monitor
#
# Monitoring platform for reviewing Ubuntu/Centos/Windows VMs
#
# @summary  This module build a monitoring plaform using InfluxDB and Grafana.  I recommend running Telegraph
#           on local system for data ingest.
#
# @param    none
#
# @example
#   include profile::apps::monitormaster or assign in PE classifier
# == Class: profile::apps::monitormaster
class profile::apps::monitormaster (
    $influxdbversion = 'installed',
){

    firewall { '300 allow influxdb access':
        dport  => [8086],
        proto  => tcp,
        action =>  accept,
    }
    firewall { '301 allow influxdb access':
        dport  => [8083],
        proto  => tcp,
        action =>  accept,
    }
    firewall { '302 allow grafana access':
        dport  => [3000],
        proto  => tcp,
        action =>  accept,
    }
    class {'influxdb':
        ensure         => 'present',
        manage_repos   => true,
        manage_service => true,
        version        => $influxdbversion,
    }

    -> class { 'grafana':
    }

}
