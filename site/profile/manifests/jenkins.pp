# == Class: profile::jenkins
class profile::jenkins {
  include jenkins

  jenkins::plugin {'git': }
}
