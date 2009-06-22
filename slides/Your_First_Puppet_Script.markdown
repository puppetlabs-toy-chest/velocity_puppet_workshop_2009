<% code :lang => "shell-unix-generic" do %>puppet -e '<%= include('examples/first_script.pp').chomp %>'<% end %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{sudo rm -f /tmp/eh; puppet --color=false examples/first_script.pp}.chomp %> <% end %>

Try it twice.  Try it with --noop.
