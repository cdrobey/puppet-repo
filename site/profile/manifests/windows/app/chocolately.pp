# == Class: profile::windows::app::chocolatey
class profile::windows::app::chocolately {
  include chocolatey

  case $facts[operatingsystem] {
    'windows': {
      Package { provider => chocolatey, }
    }
    default: {}
  }
}
