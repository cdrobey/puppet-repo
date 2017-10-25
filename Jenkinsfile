node {
    git 'https://github.com/cdrobey/puppet-repo'

    puppet.credentials 'pe-access-token'

    stage ('Checkout Control Repo') {
      checkout scm
    }

    stage ('Deploy to production') {
      puppet.codeDeploy 'production'
    }
}