# == Class: profile::base::accounts
class profile::base::accounts {
  accounts::user { 'ubuntu':
    comment => 'Dumbass',
    uid     => '1000',
    gid     => '1000',
    sshkeys => [
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7YrtR3tfvCNWZ83k8JGdJxzha0esIKaszA/prM6asxbVRg/g4WpRFjIDRTIPcycynQ3teDjAeRXsz/Ri8bgfWQEMsAFS+M0PEQV14+qxUGeaB8AU/JodmZ1cjCEN961MAInvQnbUHYEEDDEkRo0CEG5ea4ztPvDCIBV3qW5MZbkHUuAF1s8Tpr7pO4OXkkngZEcAgUscemaQMGr/qR0fJECDnliRuGH3vFoJnZeh3ElTUM71eb3IQeMkaivQ+F1kUOZCufu59pCJbDPYF/Sk1sejv8QnUfs8f3CvuqElZ0uFjuWMgbNWRojcj1LB/TFK5M3M+94HAhzUJp/tkHDM9 chris@familyroberosn.com',
    ],
  }
}
