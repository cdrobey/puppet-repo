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
    firewall { '300 allow communication to InfluxDB and Grafana':
        dport  => [8086, 8083, 3000],
        proto  => tcp,
        action =>  accept,
    }

    class { 'influxdb':
        ensure            => 'present',
    }

    class { 'grafana':
    }
    grafana_datasource { 'influxdb':
        grafana_url      => 'http://monitor.fr.lan:3000',
        grafana_user     => 'admin',
        grafana_password => 'grafana',
        type             => 'influxdb',
        url              => 'http://localhost:8086',
        database         => 'pfsense',
        is_default       => true,
    }
    grafana_user { 'username':
        grafana_url      => 'http://localhost:3000',
        grafana_user     => 'admin',
        grafana_password => 'grafana',
        full_name        => 'Grafana User',
        password         => 'grafan',
        email            => '',
    }
}
}
