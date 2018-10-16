# puppetreporter
#
# Monitoring platform for reviewing Puppet Diagnostics
#
# @summary  This module build a monitoring plaform using InfluxDB and Grafana.  It uses the
#           Puppet Report modules to keep statistics and build dashboards for PE.
#
# @param    none
#
# @example
#   include profile::apps::puppetreporter or assign in PE classifier
# == Class: profile::apps::puppetreporter
class profile::apps::puppetreporter (
    $influxdbversion = 'installed',
){
    firewall { '300 allow communication to InfluxDB and Grafana':
        dport  => [8086, 8083, 3000],
        proto  => tcp,
        action =>  accept,
    }
    class { 'puppet_metrics_dashboard':
        add_dashboard_examples => true,
        influxdb_database_name => ['puppet_metrics','telegraf','graphite'],
        master_list            => ['co-u1604-pmp01.local.familyroberson.com'],
        consume_graphite       => true,
        configure_telegraf     => true,
        enable_telegraf        => true,
    }
}
