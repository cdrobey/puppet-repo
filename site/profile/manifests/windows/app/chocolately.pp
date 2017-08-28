# == Class: profile::windows::app::chocolatey
class profile::windows::app::chocolately {
  include chocolatey

  Package { provider => chocolatey, }
}
