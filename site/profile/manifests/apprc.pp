# == Class: profile::apprc
class profile::apprc (
    $app_name,
    $app_validate,
    $app_start,
    $app_stop,
){
    class { 'apprc':
        service_name     => $app_name,
        service_validate => $app_validate,
        service_start    => $app_start,
        service_stop     => $app_stop,
    }
}