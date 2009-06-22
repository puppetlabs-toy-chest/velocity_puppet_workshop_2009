I always start with `sudo`.

In `repo/modules/sudo/manifests/init.pp`:

<% code :lang => "puppet" do %>
class sudo {
    file { "/usr/bin/sudo":
        owner => root,
        group => wheel,
        mode => 4111
    }
}<% end %>

Add `sudo` to the default node in `site.pp`.
