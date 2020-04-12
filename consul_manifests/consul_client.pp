class { '::consul':
  config_hash => {
    'advertise_addr'   => '10.16.16.11',
    'data_dir'         => '/opt/consul',
    'log_level'        => 'INFO',
    'node_name'        => 'client',
    'retry_join'       => ['10.16.16.10']
  }
}

service { 'postfix':
  ensure => true,
  enable => true,
}

class { 'consul_template':
    service_enable   => true,
    log_level        => 'debug',
    init_style       => 'systemd',
    consul_wait      => '5s:30s',
    consul_max_stale => '1s'
}
consul_template::watch { 'postfix_config':
    template      => '/vagrant/data/common.json.ctmpl.erb',
    template_vars => {
        'var1' => 'foo',
        'var2' => 'bar',
    },
    destination   => '/etc/postfix/main.cf',
    command       => '/usr/bin/systemctl restart postfix',
}
