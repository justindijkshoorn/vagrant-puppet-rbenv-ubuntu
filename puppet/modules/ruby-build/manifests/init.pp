class ruby-build {
	exec { 'install_ruby_build':
		cwd => '/usr/local/rbenv/plugins',
		command => 'git clone https://github.com/sstephenson/ruby-build.git ruby-build',
		creates => '/usr/local/rbenv/plugins/ruby-build',
		require => Package['git-core']
	}

	file { ['/usr/local/rbenv/plugins/ruby-build']:
		ensure => directory,
		owner => 'vagrant',
		group => 'vagrant',
		mode => '0775'
	}

	file { '/etc/profile.d/ruby-build.sh':
		ensure => file,
		content => template('ruby-build/init.sh'),
		mode => '0775'
	}
}