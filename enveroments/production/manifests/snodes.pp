package_install (
    $name,
){ $name:
        ensure => installed,
        name => $name,
        provider => 'apt',
    }

node  /snode(\d+)/{
    
}
# ToDo need add vector - running, git, zabbix-agent- running, docker 27.1.2 - running,