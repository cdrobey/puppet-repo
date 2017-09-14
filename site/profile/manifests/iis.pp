# == Class: profile::iis
class profile::iis {

  $iis_features = [
    'web-server',
    'web-webserver',
    'Web-Common-Http',
    'Web-Static-Content',
    'Web-Mgmt-Tools',
    'Web-Mgmt-Console',
    'Web-Windows-Auth',
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
  -> file { 'c:\\iserver\\defaultWebSite':
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
