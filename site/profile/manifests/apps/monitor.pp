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
#   include profile::monitor or assign in PE classifier
# == Class: profile::apps::monitor
class profile::apps::monitor (
){
    firewall { '300 allow communication to InfluxDB':
        dport  => [8086, 8083],
        proto  => tcp,
        action =>  accept,
    }

    class { 'influxdb':
        ensure            => 'present',
    }
}
