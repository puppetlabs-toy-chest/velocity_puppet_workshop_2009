<%= code 'examples/class_but_no_include.pp', :lang => "puppet" %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{rm -f /tmp/foo; puppet --color=false examples/class_but_no_include.pp}.chomp %> <% end %>
