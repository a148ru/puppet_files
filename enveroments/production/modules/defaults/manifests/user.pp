define default::user (
        $title,
    ) {
        user { $title:
            ensure  =>  'present',
            gid     =>  'testers',
            groups  =>  ['sudo', 'users'],
            home    => "/home/${title}",
            ia_load_module => files,
            password => Sensitive($passwd),
            password_max_age => '-1',
            shell => '/bin/bash',
            managehome => true,
            provider => 'useradd'
        }
    }