class foo {
    file { "/tmp/foo": ensure => present }
}
include foo
