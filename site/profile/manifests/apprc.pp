# == Class: profile::apprc
class profile::apprc (
    $apps,
){
    apprc { '$apps':
    }
}