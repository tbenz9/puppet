node default {
	include dnsclient
	include golang
}


# User accounts
group { 'tbenz9':
        ensure => 'present',
        gid => '1000'
}

user { 'tbenz9':
        ensure => 'present',
        uid => '1000',
        shell => '/bin/bash',
        comment => 'Thomas Bennett',

}


# Set DNS
class { 'dnsclient':
	nameservers => [ '192.168.0.2', '1.1.1.1' ],
	search => 'unsc.local',
	options => 'timeout:1'
}

# Install Golang
class { 'golang':
	version => '1.10.1',
	workspace => '/home/tbenz9/go',
}
