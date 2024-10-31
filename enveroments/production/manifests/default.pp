node 'default' {

    $passwd='$1$bgHac1Lj$VltA/iqdUXItudg2mnnXZ0'


    define default::user { $username:
        ensure  =>  'present',
        gid     =>  'testers',
        groups  =>  ['sudo', 'users'],
        home    => "/home/${username}",
        ia_load_module => files,
        password => Sensitive($passwd),
        password_max_age => '-1',
        shell => '/bin/bash',
        managehome => true,
        provider => 'useradd'
    }

    define default::package { $pkgname:
        ensure => installed,
        name => $pkgname,
        provider => 'apt',
    }

    define default::file{ "${path}/${filename}":
        ensure => file,
        source => "${proto}${s_path}/${filename}",
        purge => true,
        owner => 'root',
        group => 'root',
        mode => '0750',
    }
    group {'testers':
        name => 'testers',
        ensure => 'present',
        ia_load_module => files,
        provider => 'groupadd',

    }

    default::user{
        username => 'test1',
    }
    default::user{
        username => 'test2',
    }
    default::user{
        username => 'test3',
    }
    
    default::package {
        pkgname => 'htop',
    }
    default::package {
        pkgname => 'curl',
    }
    default::package{
        pkgname => 'wget',
    }
    default::package{
        pkgname => 'net-tools',
    }
    default::package{
        pkgname => 'openssh-server',
    }
    default::package{
        pkgname => 'tmux',
    }
    default::package{
        pkgname => 'screen',
    }
    default::package{
        pkgname => 'nmap',
    }
    default::package{
        pkgname => 'traceroute',
    }
    default::package{
        pkgname => 'telnet',
    }
    default::package{
        pkgname => 'iptables',
    }
    -> file { '/opt/scripts':
        ensure => 'directory',
        owner  => 'root',
        group  => 'root',
        mode   => '0750',
    }
    -> default::file {
        $path => '/opt/scripts',
        $filename => 'iptables_rules.sh',
        $proto => 'puppet:///',
        $s_path => 'modules/iptables',
    }
    ~> exec {'run_rules_iptables':
        command => '/opt/scripts/iptables_rules.sh',
        path => '/bin',
        user => 'root',
        provider => 'shell',
    }
    default::package{
        pkgname => 'rsync',
    }
    default::package{
        pkgname => 'tar',
    }
    default::package{
        pkgname => 'iputils-ping',
    }
    default::package{
        pkgname => 'zabbix-agent',
    }
    -> service {'zabbix-agent':
        name => 'zabbix-agent',
        ensure => stopped,
        enable => false,
    }
    default::file{
        source => 'puppet:///modules/bashrc/ps.sh',
        $path => '/opt/scripts',
        $filename => 'ps.sh',
        $proto => 'puppet:///',
        $s_path => 'modules/bashrc',
    }
}
