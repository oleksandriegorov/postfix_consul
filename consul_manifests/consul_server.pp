class { '::consul':
  config_hash => {
    'advertise_addr'   => '10.16.16.10',
    'bootstrap_expect' => 1,
    'client_addr'      => '0.0.0.0',
    'data_dir'         => '/opt/consul',
    'log_level'        => 'INFO',
    'node_name'        => 'server',
    'server'           => true,
    'ui'               => true,
  }
}
