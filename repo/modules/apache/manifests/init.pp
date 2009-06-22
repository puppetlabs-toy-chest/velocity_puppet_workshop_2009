class apache {
    apache::vhost { 'reductivelabs.com':
        docroot => "/var/www/reductivelabs.com"
    }
    apache::vhost { 'foo.com':
        docroot => "/var/www/foo.com",
        ensure => absent
    }
}
