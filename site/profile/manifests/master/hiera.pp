# == Class: profile::master::hiera
class profile::master::hiera {

  Node_group {
    require => Package['puppetclassify'],
  }


  class { 'hiera': 
    hiera_version   =>  '5',
    hiera5_defaults =>  {"datadir" => "/etc/puppetlabs/code/environments/%{::environment}/hieradata", "data_hash" => "yaml_data"},
    hierarchy       =>  [ 
      {"name" =>  "Virtual yaml", "path"  =>  "virtual/%{::virtual}.yaml"},
      {"name" =>  "Nodes yaml", "paths" =>  ['nodes/%{::trusted.certname}.yaml', 'nodes/%{::osfamily}.yaml']},
      {"name" =>  "Default yaml file", "path" =>  "common.yaml"}, 
    ],
    manage_package  => true,
    eyaml           => true,
    eyaml_name      => hiera-eyaml,
  }
}
