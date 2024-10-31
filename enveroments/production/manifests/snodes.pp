package_install (
    $name,
){ $name:
        ensure => installed,
        name => $name,
        provider => 'apt',
    }

node  /snode(\d+)/{
    
}
# vector, git, zabbix-agent, docker 27.1.2,