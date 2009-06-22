<% code :lang => "shell-unix-generic" do %>$ puppetca --confdir /tmp/server/ --vardir /tmp/server --list<% end %>

Produces: <% code :lang => "shell-unix-generic" do %>No certificates to sign<% end %>

* Note the switching between /tmp/client and /tmp/server
* Try `puppetca --print <hostname>`
