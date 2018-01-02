# iis
#
# Install and configure iis web server.
#
# @summary  This profile install an iis web server with a specified set of features. After installation
#           completes the Default Website is relocated to a default iiserver document directory.
#
# @param    none
#
# @example
#   include profile::apps::iis or assign in PE classifier
# == Class: profile::apps::iis
class profile::apps::iis {

$iis_features = ['Web-WebServer','Web-Scripting-Tools']

  iis_feature { $iis_features:
    ensure => 'present',
  }
  -> file { 'c:\\iiserver':
    ensure => 'directory',
  }
  -> file { 'c:\\iiserver\\defaultWebSite':
    ensure => 'directory',
  }

  -> file { 'c:\\logs':
    ensure => 'directory',
  }
  -> file { 'c:\\logs\\iis':
    ensure => 'directory',
  }
  -> iis_site { 'Default Web Site':
    ensure       => 'started',
    logpath      => 'c:\\logs\\iis',
    physicalpath => 'c:\\iiserver\\DefaultWebSite',
  }
}
