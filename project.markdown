company: Reductive Labs 
title: Introduction to Managed Infrastructure with Puppet
footer:  <img src="images/Reductive-100.png" alt="Reductive Labs" align=bottom> &copy; Reductive Labs 2009

<% content_for :css do %>
#footer { padding: 3em 0;}
<% end %>


Introduction to Managed Infrastructures with Puppet
===================================================

> by Luke Kanies

> Reductive Labs, Inc.

> luke@reductivelabs.com

Presentation available at `git://github.com/reductivelabs/velocity_puppet_workshop_2009.git`


Goals
=====

* Get an Introduction to Puppet
* Build a simple Puppet Repository
* Know how to use the tools


Introduction to Puppet
======================

* It's all about Resources
* We've got a custom language
* Some executables


    Getting Help
================

* `#puppet` on irc.freenode.net
* <http://groups.google.com/group/puppet-users>
* Support Contracts :)


    Resources
=============

<%= code 'examples/ralsh.sh', :lang => "shell-unix-generic" %>

Try `ralsh package`.


    Language
============

<%= code 'examples/language.pp', :lang => "puppet" %>


    Executables
===============

* `puppet`
* `ralsh`
* `puppetd`
* `puppetmasterd`
* `puppetca`

There are more, but this is all we're covering today


Your First Puppet Script
========================

<% code :lang => "shell-unix-generic" do %>puppet -e '<%= include('examples/first_script.pp').chomp %>'<% end %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{sudo rm -f /tmp/eh; puppet --color=false examples/first_script.pp}.chomp %> <% end %>

Try it twice.  Try it with --noop.


    Your Second Puppet Script
=============================

<% code :lang => "shell-unix-generic" do %>puppet -e '<%= include('examples/second_script.pp').chomp %>'<% end %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{touch /tmp/eh; puppet --color=false examples/second_script.pp}.chomp %> <% end %>


    Puppet Classes
==================

<%= code 'examples/class_but_no_include.pp', :lang => "puppet" %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{sudo rm -f /tmp/foo; puppet --color=false examples/class_but_no_include.pp}.chomp %> <% end %>


    Including Classes
=====================

<%= code 'examples/class_with_include.pp', :lang => "puppet" %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{sudo rm -f /tmp/foo; puppet --color=false examples/class_with_include.pp}.chomp %> <% end %>



A Puppet Repository
===================

Basic Repository Structure:
<% code :lang => "shell-unix-generic" do %>manifests/site.pp
modules/
modules/mymod/manifests/init.pp
modules/mymod/templates/mytemplate.erb
modules/mymod/plugins/puppet/parser/functions/myfunction.rb<% end %>


    Your First Module
=====================

<% code :lang => "shell-unix-generic" do %>mkdir repo
mkdir -p repo/manifests repo/modules/foo/manifests
cp examples/class_but_no_include.pp repo/modules/foo/manifests/init.pp<% end %>

To use: <% code :lang => "shell-unix-generic" do %>puppet --modulepath repo/modules -e 'include foo'<% end %>


    Your First Node
===================

<%= code "repo/manifests/site.pp", :lang => "puppet" %>


    Putting It Together
=======================

<% code :lang => "shell-unix-generic" do %>puppet --modulepath repo/modules repo/manifests/site.pp<% end %>

You now have a "complete" Puppet repository, ready to extend.


Starting The Server
===================

<% code :lang => "shell-unix-generic" do %>puppetmasterd --verbose --no-daemonize --modulepath $PWD/repo/modules \
--confdir /tmp/server --vardir /tmp/server \
--manifest $PWD/repo/manifests/site.pp --certdnsnames localhost<% end %>

Produces: <% code :lang => "shell-unix-generic" do %>info: Starting server for Puppet version 0.24.8
info: Creating a new certificate request for phage.local
info: Creating a new SSL key at /tmp/server/ssl/private_keys/phage.local.pem
info: Autosign is enabled but /tmp/server/autosign.conf is missing
info: Signing certificate for CA server
info: Signing certificate for phage.local
info: Listening on port 8140
notice: Starting Puppet server version 0.24.8<% end %>

Usually runs as 'puppet' but doesn't have to.


    Server Arguments
====================

* `--verbose`: Provide extra logging
* `--no-daemonize`: Do not background
* `--modulepath $PWD/repo/modules`: Specify where to find our modules
* `--confdir /tmp/server`: Use a non-standard configuration directory
* `--vardir /tmp/server`: Use a non-standard state/var directory
* `--manifest $PWD/repo/manifests/site.pp`: Specify the starting manifest to parse
* `--certdnsnames localhost`: Configure `localhost` as an alias in the SSL Certificate


    Default Server Arguments
============================

<%= code "examples/default_server_arguments.sh", :lang => "shell-unix-generic" %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{bash examples/default_server_arguments.sh}.chomp %> <% end %>


    Running The Agent
=====================

<% code :lang => "shell-unix-generic" do %>sudo puppetd --test --confdir /tmp/server --vardir /tmp/server --server localhost<% end %>

Produces: <% code :lang => "shell-unix-generic" do %>info: Caching catalog at /tmp/server/state/localconfig.yaml
notice: Starting catalog run
notice: //Node[default]/foo/File[/tmp/foo]/ensure: created
notice: Finished catalog run in 0.01 seconds<% end %>

Note that we're running as root


    Agent Arguments
===================

* `--test`: Very helpful argument rollup
* `--confdir /tmp/server`: Use a non-standard configuration directory
* `--vardir /tmp/server`: Use a non-standard state/var directory
* `--server localhost`: Specify the server to contact


    Certificates
================

This is just Standard SSL(tm).

1. Generate Certificate Signing Request (CSR)
2. Send CSR to server
3. Server signs CSR and produces Certificate
4. Client retrieves Certificate


    Welcome to the Certificate Authority
========================================

<% code :lang => "shell-unix-generic" do %>puppetca --confdir /tmp/server/ --vardir /tmp/server --list<% end %>

Produces: <% code :lang => "shell-unix-generic" do %>No certificates to sign<% end %>

* Try `puppetca --print <hostname>`


    Signing Client Certificates
===============================

Note the switch to `/tmp/client`:
<% code :lang => "shell-unix-generic" do %>sudo puppetd --test --confdir /tmp/client --vardir /tmp/client \
--server localhost --certname other.madstop.com<% end %>
On the server:<% code :lang => "shell-unix-generic" do %>notice: Host other.madstop.com has a waiting certificate request<% end %>

<% code :lang => "shell-unix-generic" do %>puppetca --confdir /tmp/server/ --vardir /tmp/server --list
puppetca --confdir /tmp/server/ --vardir /tmp/server --sign other.madstop.com<% end %>

Now run the client again.


Doing Something Useful
======================

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


    Managing Files
==================

Create your sudoers file at `repo/modules/sudo/files/sudoers`, then add this to your `init.pp`:

<% code :lang => "puppet" do %>file { "/etc/sudoers":
    owner => root,
    group => wheel,
    mode => 440,
    source => "puppet:///sudo/sudoers"
}<% end %>


    Managing Heterogeneity
==========================

<% code :lang => "puppet" do %>file { sudo:
    path => $operatingsystem ? {
        darwin => "/usr/bin/sudo",
        default => "/usr/sbin/sudo",
    },
    owner => root,
    group => 0,
    mode => 4111
}<% end %>


    Facter
==========

<% code :lang => "shell-unix-generic" do %>$ facter | wc -l
<%= %x{facter | wc -l}.chomp %>
$ facter | grep name
<%= %x{facter | grep name}.chomp %>
$ <% end %>


Other Language Functions
========================

In general, rely on the tutorial on the wiki, not me


    Relationships
=================

<%= code 'repo/modules/rels/manifests/init.pp', :lang => "puppet" %>
Produces: <% code :lang => "shell-unix-generic" do %><%= %x{sudo rm -f /tmp/reltest; puppet --color=false --modulepath $PWD/repo/modules -e 'include rels'}.chomp %> <% end %>


Definitions
===========

* Can be considered a 'composite resource'
* A simple way to model resources within Puppet's language


    Apache Virtual Hosts
========================

<%= code 'repo/modules/apache/manifests/vhost.pp', :lang => "puppet" %>

Note the qualified definition name.  This is required for correct autoloading.


    Using Definitions
=====================

<%= code 'repo/modules/apache/manifests/init.pp', :lang => "puppet" %>



    Complicated Virtual Host
============================

<%= code 'repo/modules/apache/manifests/vhost2.pp', :lang => "puppet" %>


Things We Skipped
=================

* Reporting
* Queueing
* Inheritance
* Storeconfigs
* Export/Collect
* Everything else we didn't cover


Obligatory Pitch
================

Reductive Labs provides support contracts, training, and custom development, and we use all of the revenue to fund development, this kind of talk, and eating.  Well, almost all.


Conclusion
==========

![The Villain](images/villain.jpg)

> 

luke@reductivelabs.com


