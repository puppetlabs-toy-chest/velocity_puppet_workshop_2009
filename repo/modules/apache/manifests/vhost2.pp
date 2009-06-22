define apache::vhost2($docroot, $ensure = present) {
    $available => $ensure ? { enabled => present, default => $ensure }
    $enabled => $ensure ? { enabled => symlink, default => absent }
    file { "/tmp/apache/sites-available/$name":
        content => template("apache/vhost.erb"),
        ensure => $available
    }
    file { "/tmp/apache/sites-enabled/$name":
        target => "/tmp/apache/sites-available/$name",
        ensure => $enabled
    }
}
