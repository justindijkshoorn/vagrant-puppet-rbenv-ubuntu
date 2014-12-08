# Vagrant, Puppet, RBENV setup

## Instructions
Before diving into your first project, please [install Vagrant](http://docs.vagrantup.com/v2/installation/). And because we'll be using [VirtualBox](http://www.virtualbox.org/) as our provider, please install that as well.

When installed navigate to the vagrant-puppet-lamp-ubuntu folder and run the following command

	$ vagrant up

This will automatically download the latest ubuntu server version for you from

	$ https://cloud-images.ubuntu.com/vagrant/utopic/current/utopic-server-cloudimg-i386-vagrant-disk1.box

After running the above command (vagrant up), you'll have a fully running virtual machine in VirtualBox running the latest Ubuntu Server 32-bit with a pre-installed RBENV stack. You can SSH into this machine with vagrant ssh, and when you're done playing around, you can remove all traces of it with vagrant destroy.

## Install ruby using rbenv
SSH into your Vagrant box and run the following commands

	$ rbenv install 2.1.2
	$ rbenv global 2.1.2

The installation could take a while ...

## Install rails
After you've installed ruby via rbenv you can install the rails gem

	$ gem install rails

If you're using rbenv, you'll need to run the following command (also after installing new gems) to make the rails executable (gems) available

	$ rbenv rehash

###### Note: Never run rbenv rehash again. This rbenv plugin automatically runs rbenv rehash every time you install or uninstall a gem. For more information see: [https://github.com/sstephenson/rbenv-gem-rehash](https://github.com/sstephenson/rbenv-gem-rehash)

	$ git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

Now that you've installed Rails, you can run the rails -v command to make sure you have everything installed correctly

	$ rails -v

And now for the moment of truth. Let's create your Rails application (inside vagrant Synced folder)

	$ cd vagrant-data/
	$ rails new myapp

	# If you want to use MySQL
	# MySql username: root
	# MySql password is unset use the following command to set: sudo mysqladmin -uroot password yourpassword

	$ rails new myapp -d mysql

	# Create the database
	$ rake db:create

	$ rails server -e development

###### Note: Socket in rails config/database.yml should be set to:
	/var/run/mysqld/mysqld.sock

## Vagrant Synced folders
[Synced folders](http://docs.vagrantup.com/v2/synced-folders/index.html) is enabled to sync a folder on the host machine to the guest machine, allowing you to continue working on your project's files on your host machine, but use the resources in the guest machine to compile or run your project. You can see the working folder when you point your browser to

	$ http://localhost:3000

Be sure your rails server is running within the vagrant box ...

## Note: NodeJS
Since Rails ships with so many dependencies these days Javascript runtime NodeJS is installed. This lets you use Coffeescript and the Asset Pipeline in Rails which combines and minifies your javascript to provide a faster production environment.

## Note: NFS
If you are using Vagrant and facing performance hits while running web-server or unit tests, the solution can be using NFS. It is used for sharing folders between host and guest machines. Vagrant uses VirtualBox default sharing mechanism, which is very slow. After you'll switch to NFS, file access speed will increase by ~ 10 - 100 times. More information can be found in the [https://docs.vagrantup.com/v2/synced-folders/nfs.html](Vagrant docs).

## Note: RBENV build failed on Ubuntu 14.10

    # Bug has been fixed for ruby >= 2.0.0 !
    # Ubuntu 14.10 is used ...

~~Because Ubuntu 14.10 is probably shipping with readline 6.3, which uses rl_hook_func_t instead of Function. This bug has already been reported and fixed in Ruby (https://bugs.ruby-lang.org/issues/9578), but not released yet. Until Ruby 2.1.2 comes out (which I assume will contain this fix) Ubuntu 12.04 is used.~~
