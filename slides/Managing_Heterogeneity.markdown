<% code :lang => "puppet" do %>file { sudo:
    path => $operatingsystem ? {
        darwin => "/usr/bin/sudo",
        default => "/usr/sbin/sudo",
    },
    owner => root,
    group => 0,
    mode => 4111
}<% end %>
