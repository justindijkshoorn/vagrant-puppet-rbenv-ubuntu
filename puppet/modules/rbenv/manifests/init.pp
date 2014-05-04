class rbenv {
	$rbenvPackages = ['git-core', 'curl', 'zlib1g-dev', 'libssl-dev', 'libreadline-dev', 'libyaml-dev', 'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt1-dev']
	package { $rbenvPackages:
		ensure => present,
		require => Class['system-update']
	}

	exec { 'install_rbenv':
		cwd => '/usr/local',
		command => 'git clone https://github.com/sstephenson/rbenv.git rbenv',
		creates => '/usr/local/rbenv',
		require => Package['git-core']
	}

	file { ['/usr/local/rbenv', '/usr/local/rbenv/plugins', '/usr/local/rbenv/shims', '/usr/local/rbenv/versions']:
		ensure => directory,
		owner => 'vagrant',
		group => 'vagrant',
		mode => '0775'
	}

	file { '/etc/profile.d/rbenv.sh':
		ensure => file,
		content => template('rbenv/init.sh'),
		mode => '0775'
	}

	Exec['install_rbenv'] -> File['/usr/local/rbenv']
}