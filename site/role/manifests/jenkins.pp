# jenkins
#
# Install and configure base jenkins system.
#
# @summary  This role delivers a jenkins application work server and incorporates the PE Jenkins Plug-in
#           to integrate Puppet Pipelines.  Additionally a baseline linux profile is applied to the application
#           role.
#
# @param    none
#
# @example
#   include role::jenkins or assign in PE classifier
# == Class: role::jenkins
class role::jenkins {
  include profile::base
  include profile::apps::jenkins
}
