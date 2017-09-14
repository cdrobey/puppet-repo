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

  -> iis_site { 'Default Web Site':
    logpath      => 'c:\\logs\\IIS',
    physicalpath => 'c:\\iserver\\DefaultWebSite',
  }

  -> file { ['c:\\iserver', 'c:\\iserver\\DefaultWebSite','c:\\Logs','c:\\Logs\\IIS']:
    ensure => 'directory',
  }
}
