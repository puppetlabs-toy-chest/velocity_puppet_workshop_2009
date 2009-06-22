define apache::vhost($docroot, $ensure = present) {
    file { "/tmp/apache/sites/$name":
        content => template("apache/vhost.erb"),
        ensure => $ensure
    }
}
