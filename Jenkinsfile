node {
  stage ('Checkout Control Repo') {
    checkout scm
  }
  stage ('Check Style - Lint') {
    sh 'echo $(find . -type f -name "*.pp" \\( -exec /opt/puppetlabs/puppet/bin/puppet-lint --with-filename {} \\; -o -quit \\) 2>&1 ) | grep -v ERROR'
  }
  stage ('Check Syntax - Parse') {
    sh 'echo $(find . -type f -name "*.pp" \\( -exec /opt/puppetlabs/bin/puppet parser validate {} \\; -o -quit \\) 2>&1 ) | grep -v Error'
  }
  stage ('Code Deploy to Master') {
    puppet.credentials 'pe-access-token'
    puppet.codeDeploy 'production'
  }
  stage ('Production run') {
    puppet.credentials 'pe-access-token'
    puppet.job ‘production’, nodes: [‘linux01.fr.lan’]
  }
}