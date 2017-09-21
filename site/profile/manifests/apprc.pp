# == Class: profile::apprc
class profile::apprc (
    $app_name,
    $app_validate,
    $app_start,
    $app_stop,
    $app_proc,
){
    class { 'apprc':
        app_name     => $app_name,
        app_validate => $app_validate,
        app_start    => $app_start,
        app_stop     => $app_stop,
        app_proc     => $app_proc,
    }
}