class rels {
    file { "/tmp/reltest": ensure => present }
    exec { "/bin/echo got notified":
        subscribe => File["/tmp/reltest"],
        refreshonly => true
    }
}
