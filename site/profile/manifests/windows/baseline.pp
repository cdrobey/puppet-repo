# == Class: profile::windows::baseline
class profile::windows::baseline {

  # CORP PACKAGES
  Package {
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'notepadplusplus': }
  package { '7zip': }
  package { 'git': }


  # CUSTOM USERS
}
