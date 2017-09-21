# == Class: profile::apprc
class profile::apprc (
    $apps,
){
    class { 'apprc':
        apps => $apps,
    }
}