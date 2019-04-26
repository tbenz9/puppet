node default {
	include dnsclient
	include ssh::server
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
	home => '/home/tbenz9',
	managehome => 'true',
}

file { '/home/tbenz9/.ssh':
        ensure => 'directory',
        owner => 'tbenz9',
        group => 'tbenz9',
        mode => '600',
        recurse => 'true',
}

ssh_authorized_key { 'tbenz9@raspberrypi':
        name => 'tbenz9@raspberrypi',
        ensure => 'present',
        type => 'ssh-rsa',
        user => 'root',
        key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDB2mDzCcidSi6/M+MxFcWG0J1MEgJ1reKrSGbRBdJLNW5/SzO84S2GxLptZjPOCyvXZdbem4JdyY22sXW4z4a9v/IaS03I+a5w3zDzW0SRLAg7qG6gSJrpfLKn2isxaV1A4xqxGtnqHt1lLZYUSd/m6GmMS/9rTsLJSSPzVcbMzXr51YtusbytLQFDWLLdcchn2eR4rHVuGqq3q2jRaR63kp5hnaQZDWku3uRYGzenjGzwUT2NitS3UNMPdFvnHNnxCFzNMBl9k6kfe8ZObj+NcKS992W6drkTYDSEikXZAEkqY1spM+1GK4dMginT171EnBbrtbYwn4OYNf2dc+dH',
}

# packages
class packages {
    $packages = [ 'curl', 'vim', 'iotop', 'vnstat' ]
    package { $enhancers: ensure => 'installed' }
}

# Set DNS
class { 'dnsclient':
        nameservers => [ '192.168.0.2', '1.1.1.1' ],
        search => 'unsc.local',
        options => 'timeout:1'
}

# Configure SSH Server
class { 'ssh::server':
	options => {
		'PermitRootLogin' => 'without-password',
	}
}

class { 'golang':
  base_dir    => '/usr/local/go',
  from_repo   => true,
  repo_version => 'go1.12',
  goroot      => '',
  workdir     => '/home/tbenz9/go',
}
