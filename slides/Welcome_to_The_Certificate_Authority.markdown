<% code :lang => "shell-unix-generic" do %>puppetca --confdir /tmp/server/ --vardir /tmp/server --list<% end %>

Produces: <% code :lang => "shell-unix-generic" do %>No certificates to sign<% end %>

* Try `puppetca --print <hostname>`
