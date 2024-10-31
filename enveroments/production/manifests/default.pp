$passwd='$1$bgHac1Lj$VltA/iqdUXItudg2mnnXZ0'

class test_users (
    $name,
    ) {$name:
    ensure  =>  'present',
    gid     =>  'testers',
    groups  =>  ['sudo', 'users'],
    home    => "/home/${name}",
    ia_load_module => files,
    password => Sensitive($passwd),
    password_max_age => '-1',
    shell => '/bin/bash',
    managehome => true,
    provider => 'useradd'
}

package_install (
    $name,
){ $name:
        ensure => installed,
        name => $name,
        provider => 'apt',
    }

node 'default' {
    group {'testers':
        name => 'testers',
        ensure => 'present',
        ia_load_module => files,
        provider => 'groupadd',

    }
    -> user {
        $name='test1',
        include test_users,
    }
     -> user {
        $name='test2',
        include test_users,
    }
     -> user {
        $name='test3',
        include test_users,
    }
    package_install {
        $name = 'htop',
        include package
    }
    package_install {
        $name = 'curl',
        include package
    }
    package_install {
        $name = 'wget',
        include package
    }
    package_install {
        $name = 'net-tools',
        include package
    }
    package_install {
        $name = 'openssh-server',
        include package
    }
    package_install {
        $name = 'tmux',
        include package
    }
    package_install {
        $name = 'screen',
        include package
    }
    package_install {
        $name = 'nmap',
        include package
    }
    package_install {
        $name = 'traceroute',
        include package
    }
    package_install {
        $name = 'telnet',
        include package
    }
    package_install {
        $name = 'iptables',
        include package
    }
    -> file { '/opt/scripts':
        ensure => 'directory',
        owner  => 'root',
        group  => 'root',
        mode   => '0750',
    }
    -> file {'/opt/scripts/iptables_rules.sh':
        ensure => file,
        source => 'puppet:///modules/iptables/iptables_rules.sh',
        purge => true,
        owner => 'root',
        group => 'root',
        mode => '0750',
    }
    -> exec {'run_rules_iptables':
        command => '/opt/scripts/iptables_rules.sh',
        path => '/bin',
        user => 'root',
        provider => 'shell',
    }
    package_install {
        $name = 'rsync',
        include package
    }
    package_install {
        $name = 'tar',
        include package
    }
    package_install {
        $name = 'iputils-ping',
        include package
    }
    package_install {
        $name = 'zabbix-agent',
        include package
    }
    -> service {'zabbix-agent':
        name => 'zabbix-agent',
        ensure => stopped,
        enable => false,
    }

}
