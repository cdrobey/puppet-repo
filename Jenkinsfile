node {
  stage 'Checkout Control Repo' {
      checkout scm
  }
  stage 'Deploy to staging'
  lock(‘puppet-code-staging’) {
    puppet.codeDeploy 'staging'
    puppet.job 'staging'
  }
}