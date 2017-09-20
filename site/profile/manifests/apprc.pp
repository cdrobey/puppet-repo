# == Class: profile::apprc
class profile::apprc {
    class { 'apprc':
        service_name => 'testing',
    }
}
