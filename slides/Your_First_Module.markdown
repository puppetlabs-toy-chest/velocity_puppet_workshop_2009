<% code :lang => "shell-unix-generic" do %>mkdir repo
mkdir -p repo/manifests repo/modules/foo/manifests
cp examples/class_but_no_include.pp repo/modules/foo/manifests/init.pp<% end %>

To use: <% code :lang => "shell-unix-generic" do %>puppet --modulepath repo/modules -e 'include foo'<% end %>
