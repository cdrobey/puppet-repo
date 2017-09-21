# == Class: profile::apprc
class profile::apprc {
    class { 'apprc':
        service_name     => 'testsvc',
        service_validate => 'testvalidate',
        service_start    => 'Overriding the starting value.',
    }
}
