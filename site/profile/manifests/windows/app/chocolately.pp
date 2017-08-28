# == Class: profile::windows::app::chocolatey
class profile::windows::app::chocolatey {
  include chocolatey

  Package { provider => chocolatey, }
}
