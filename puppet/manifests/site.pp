if $operatingsystem == 'Ubuntu' {
	notice("Correct operating system found, ${operatingsystem}!")

	Exec {
		path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ]
	}

	include bootstrap
	include system-update
	include mysql
	include rbenv
	include ruby-build
	include nodejs
} else {
	warning("I dont know what to think about ${operatingsystem}. Its a ${osfamily}, isnt it? We need Ubuntu!")
}