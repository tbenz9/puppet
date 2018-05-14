node default {
	include dnsclient
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

ssh_authorized_key { 'tbenz9@raspberrypi':
        name => 'tbenz9@raspberrypi',
        ensure => 'present',
        type => 'ssh-rsa',
        user => 'root',
        key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDB2mDzCcidSi6/M+MxFcWG0J1MEgJ1reKrSGbRBdJLNW5/SzO84S2GxLptZjPOCyvXZdbem4JdyY22sXW4z4a9v/IaS03I+a5w3zDzW0SRLAg7qG6gSJrpfLKn2isxaV1A4xqxGtnqHt1lLZYUSd/m6GmMS/9rTsLJSSPzVcbMzXr51YtusbytLQFDWLLdcchn2eR4rHVuGqq3q2jRaR63kp5hnaQZDWku3uRYGzenjGzwUT2NitS3UNMPdFvnHNnxCFzNMBl9k6kfe8ZObj+NcKS992W6drkTYDSEikXZAEkqY1spM+1GK4dMginT171EnBbrtbYwn4OYNf2dc+dH',
}

# packages
package { 'golang':
        name => 'golang-go',
        ensure => 'present',
}
package { 'curl':
        name => 'curl',
        ensure => 'present',
}
package { 'vim':
        name => 'vim',
        ensure => 'present',
}

# Set DNS
class { 'dnsclient':
        nameservers => [ '192.168.0.2', '1.1.1.1' ],
        search => 'unsc.local',
        options => 'timeout:1'
}
