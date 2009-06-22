class sudo {
    file { "/usr/bin/sudo":
        owner => root,
        group => wheel,
        mode => 4111
    }
}
