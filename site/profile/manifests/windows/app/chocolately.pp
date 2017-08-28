# == Class: profile::windows::app::chocolatey
class profile::windows::app::chocolately {
  include chocolatey

  case $operatingsystem {
    'windows': {
      Package { provider => chocolatey, }
    }
  }
}
