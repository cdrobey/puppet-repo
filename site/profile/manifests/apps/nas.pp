# nas
#
# Install and configure nas file server profile.
#
# @summary  This profiles uses the several modules to configure an installation of a file server.  The module loads the application from the primary ubiquiti application reposibioties.
# 
#
# @param    none
#
# @example
#   include profile::apps::nas or assign in PE classifier
# == Class: profile::apps::nas
class profile::apps::nas (
  $repo_release = 'stable',
  $package_ensure = 'latest',
){
}
