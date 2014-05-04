# Vagrant, Puppet, RBENV setup

## Instructions
Before diving into your first project, please [install Vagrant](http://docs.vagrantup.com/v2/installation/). And because we'll be using [VirtualBox](http://www.virtualbox.org/) as our provider, please install that as well.

When installed navigate to the vagrant-puppet-lamp-ubuntu folder and run the following command

	$ vagrant up

This will automatically download the latest ubuntu server version for you from

	$ https://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-i386-vagrant-disk1.box

After running the above command (vagrant up), you'll have a fully running virtual machine in VirtualBox running the latest Ubuntu Server 32-bit with a pre-installed RBENV stack. You can SSH into this machine with vagrant ssh, and when you're done playing around, you can remove all traces of it with vagrant destroy.

## Install ruby using rbenv
SSH into your Vagrant box and run the following commands

	$ rbenv install 2.1.1
	$ rbenv global 2.1.1

The installation could take a while ...

## Install rails
After you've installed ruby via rbenv you can install the rails gem

	$ gem install rails

If you're using rbenv, you'll need to run the following command to make the rails executable available

	$ rbenv rehash

Now that you've installed Rails, you can run the rails -v command to make sure you have everything installed correctly

	$ rails -v

And now for the moment of truth. Let's create your Rails application

	$ rails new myapp

	# If you want to use MySQL
	$ rails new myapp -d mysql

	# Create the database
	$ rake db:create

	$ rails server -e development

## Vagrant Synced folders
[Synced folders](http://docs.vagrantup.com/v2/synced-folders/index.html) is enabled to sync a folder on the host machine to the guest machine, allowing you to continue working on your project's files on your host machine, but use the resources in the guest machine to compile or run your project. You can see the working folder when you point your browser to

	$ http://localhost:3000

Be sure your rails server is running within the vagrant box ...

## Note: NodeJS
Since Rails ships with so many dependencies these days, we're going to need to install a Javascript runtime like NodeJS. This lets you use Coffeescript and the Asset Pipeline in Rails which combines and minifies your javascript to provide a faster production environment.

To install NodeJS, add it using a PPA repository

	$ sudo add-apt-repository ppa:chris-lea/node.js
	$ sudo apt-get update
	$ sudo apt-get install nodejs

## Note: RBENV build failed on Ubuntu 14.04
Because Ubuntu 14.04 is probably shipping with readline 6.3, which uses rl_hook_func_t instead of Function. This bug has already been reported and fixed in Ruby (https://bugs.ruby-lang.org/issues/9578), but not released yet. Until Ruby 2.1.2 comes out (which I assume will contain this fix) Ubuntu 12.04 is used.