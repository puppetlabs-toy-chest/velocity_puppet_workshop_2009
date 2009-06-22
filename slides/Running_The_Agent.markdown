<% code :lang => "shell-unix-generic" do %>puppetd --test --confdir /tmp/server --vardir /tmp/server --server $hostname<% end %>

Produces: <% code :lang => "shell-unix-generic" do %>info: Starting server for Puppet version 0.24.8
info: Creating a new certificate request for phage.local
info: Creating a new SSL key at /tmp/server/ssl/private_keys/phage.local.pem
info: Autosign is enabled but /tmp/server/autosign.conf is missing
info: Signing certificate for CA server
info: Signing certificate for phage.local
info: Listening on port 8140
notice: Starting Puppet server version 0.24.8
<% end %>
