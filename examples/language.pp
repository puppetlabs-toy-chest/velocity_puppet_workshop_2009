file { "/tmp/example_file":
    ensure => present
    content => "This is a test\n",
    mode => 640
}
