define default::file (
        $title,
        $s_path,
        $path = '/opt/scripts',
        $proto = 'puppet:///',
    ) { 
        file { "${path}/${title}":
            ensure => file,
            source => "${proto}${s_path}/${title}",
            purge => true,
            owner => 'root',
            group => 'root',
            mode => '0750',
        }
    }