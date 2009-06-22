<% code :lang => "shell-unix-generic" do %>sudo puppetd --test --confdir /tmp/server --vardir /tmp/server --server localhost<% end %>

Produces: <% code :lang => "shell-unix-generic" do %>info: Caching catalog at /tmp/server/state/localconfig.yaml
notice: Starting catalog run
notice: //Node[default]/foo/File[/tmp/foo]/ensure: created
notice: Finished catalog run in 0.01 seconds<% end %>

Note that we're running as root
