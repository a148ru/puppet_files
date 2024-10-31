node 'default' {

    $passwd='$1$bgHac1Lj$VltA/iqdUXItudg2mnnXZ0'

    group { 'testers':
        name => 'testers',
        ensure => 'present',
        ia_load_module => files,
        provider => 'groupadd',
    }

    default::user { 'test1': }
    default::user { 'test2': }
    default::user { 'test3': }
    
    default::package { 'htop': }
    default::package { 'curl': }
    default::package { 'wget': }
    default::package { 'net-tools': }
    default::package { 'openssh-server': }
    default::package { 'tmux': }
    default::package { 'screen': }
    default::package { 'nmap': }
    default::package { 'traceroute': }
    default::package { 'telnet': }
    default::package { 'iptables': }
    -> file { '/opt/scripts':
        ensure => 'directory',
        owner  => 'root',
        group  => 'root',
        mode   => '0750',
    }
    -> default::file { 'iptables_rules.sh': s_path => 'modules/iptables', }
    ~> exec { 'run_rules_iptables':
        command => '/opt/scripts/iptables_rules.sh',
        path => '/bin',
        user => 'root',
        provider => 'shell',
    }
    default::package { 'rsync': }
    default::package { 'tar': }
    default::package { 'iputils-ping': }
    default::package { 'zabbix-agent': }
    -> service { 'zabbix-agent':
        name => 'zabbix-agent',
        ensure => stopped,
        enable => false,
    }
    default::file { 'ps.sh': s_path => 'modules/bashrc', }
}
