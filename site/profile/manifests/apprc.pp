# == Class: profile::apprc
class profile::apprc {
    class { 'apprc':
        service_name     => 'testsvc',
        service_validate => 'testvalidate',
        server_start     => 'Overriding the starting value.',
    }
}
