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
#   include profile::appc or assign in PE classifier
# == Class: profile::apps::influ
class profile::apps::monitor (
    $port,
){
    firewall { '300 allow communication to InfluxDB':
        dport  => [8083],
        proto  => tcp,
        action =>  accept,
    }

    class { 'influxdb': }
}
