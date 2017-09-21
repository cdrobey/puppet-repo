# == Class: profile::apprc
class profile::apprc {
    class { 'apprc':
        service_name     => 'testsvc',
        service_validate => 'testvalidate',
        service_start    => 'echo this is a start test.'
        service_stop     => 'echo this is a stop test.'
    }
}
