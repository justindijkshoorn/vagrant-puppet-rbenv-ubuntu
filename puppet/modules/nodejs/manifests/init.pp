class nodejs {
	package { nodejs:
		ensure => present,
		require => Class['system-update']
	}	
}