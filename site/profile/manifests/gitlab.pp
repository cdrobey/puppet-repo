# == Class: profile::gitlab
class profile::gitlab {

  $external_url = hiera('profile::gitlab::external_url')
  $time_zone = hiera('profile::gitlab::gitlab_rails::timezone')
  $gitlab_email_enabled = hiera('profile::gitlab::gitlab_rails::gitlab_email_enabled')
  $gitlab_default_theme = hiera('profile::gitlab::gitlab_rails::gitlab_default_theme')
  $gitlab_email_display_name = hiera('profile::gitlab::gitlab_rails::gitlab_email_display_name')
  $shutdown_timeout = hiera('profile::gitlab::sidekiq::shutdown_timeout')

  firewall { '80 allow apache access':
    dport  => [80],
    proto  => tcp,
    action => accept,
  }
  class {'gitlab':
    external_url => $external_url,
  }
  class {'gitlab::git_rails':
    time_zone                 => $time_zone,
    gitlab_email_enabled      => $gitlab_email_enabled,
    gitlab_default_theme      => $gitlab_default_theme,
    gitlab_email_display_name => $gitlab_email_display_name,
  }
  class { 'gitlab::sidekiq':
    shutdown_timeout => $shutdown_timeout,
  }
}
