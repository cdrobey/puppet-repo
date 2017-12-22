# appc
#
# Use apprc modules to install rc scripts used for testing.
#
# @summary  This profiles installes a list of scripts used for testing and deploying new application upgrades.
#           A list of application may be specified in hiera files.
#
# @param    apps - a hased list of application rc scripts mapped to setup a test environment on boot of 
#           server
#
# @example
#   include profile::appc or assign in PE classifier
# == Class: profile::apps::apprc
class profile::apps::apprc (
    $apps,
){
    class { 'apprc':
        apps => $apps,
    }
}
