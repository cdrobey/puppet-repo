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

  $iis_features = [
    'web-server',
    'web-webserver',
    'Web-Common-Http',
    'Web-Static-Content',
    'Web-Mgmt-Tools',
    'Web-Mgmt-Console',
    'Web-iis-Auth',
    'Web-Stat-Compression',
    'Web-Dyn-Compression',
    'Web-Dir-Browsing',
    'Web-Http-Errors',
    'Web-Http-Logging',
    'Web-Default-Doc',
    'Web-Asp-Net',
    'Web-Includes',
    'Web-Filtering',
    'Web-Mgmt-Service',
    'Web-Security',
    'Web-Basic-Auth',
    'Web-Performance',
    'Web-Request-Monitor',
    'Web-App-Dev',
    'Web-Health',
    'Web-Http-Redirect'
  ]

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
    ensure       => 'present',
    logpath      => 'c:\\logs\\iis',
    physicalpath => 'c:\\iiserver\\DefaultWebSite',
  }
}
