define default::package (
        $title,
    ) { 
        package { $title:
            ensure => installed,
            name => $title,
            provider => 'apt',
        }
    }