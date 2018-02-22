# nas
#
# Install and configure nas file server
#
# @summary  This role delivers a nas file server to provide, nfs, smb, and afp services.
#           NAS provides a service for windows file sharing, vmware mountpionts and timemachine backups.
#
# @param    none
#
# @example
#   include role::nas or assign in PE classifier
# == Class: role::nas
class role::nas {
  include profile::base
  include profile::os::monitor
  include profile::apps::samba
}
