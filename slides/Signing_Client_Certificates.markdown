Note the switch to `/tmp/client`:
<% code :lang => "shell-unix-generic" do %>sudo puppetd --test --confdir /tmp/client --vardir /tmp/client \
--server localhost --certname other.madstop.com<% end %>
On the server:<% code :lang => "shell-unix-generic" do %>notice: Host other.madstop.com has a waiting certificate request<% end %>

<% code :lang => "shell-unix-generic" do %>puppetca --confdir /tmp/server/ --vardir /tmp/server --list
puppetca --confdir /tmp/server/ --vardir /tmp/server --sign other.madstop.com<% end %>

Now run the client again.
