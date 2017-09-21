# == Class: profile::apprc
class profile::apprc (
    service_name,
    service_validate,
    service_start,
    service_stop,
){
    class { 'apprc':
        service_name     => $app_name,
        service_validate => $app_validate,
        service_start    => $app_start,
        service_start    => $app_stop,
    }
}