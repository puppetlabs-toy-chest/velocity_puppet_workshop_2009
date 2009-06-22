Basic Repository Structure:
<% code :lang => "shell-unix-generic" do %>manifests/site.pp
modules/
modules/mymod/manifests/init.pp
modules/mymod/templates/mytemplate.erb
modules/mymod/plugins/puppet/parser/functions/myfunction.rb<% end %>
