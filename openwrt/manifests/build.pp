class openwrt::build {
require openwrt::params
case $operatingsystem {

	'centos': { $buildpackages = ['perl','subversion','gawk','unzip','ncurses-devel','zlib-devel','gcc-c++'] 
		file { "/etc/yum.repos.d/epel-testing.repo":
			ensure => present,
			source => "puppet:///modules/openwrt/epel-testing.repo",
		}
		package { 'perl-Git':
			provider	=> 'yum',
			ensure		=> installed,
			require		=> File['/etc/yum.repos.d/epel-testing.repo'],
		}
	}	

	'redhat': { $buildpackages = ['binutils','bzip2','gawk','gcc','gcc-c++','gettext','make','ncurses-devel','patch','unzip','wget','zlib-devel','flex','git-core'] 
		}

	'ubuntu': { $buildpackages = ['build-essential','subversion','libncurses5-dev','zlib1g-dev','gawk','gcc-multilib','flex','git-core','gettext','unzip','ia32-libs'] 
		}
}

user { "${openwrt::params::builduser}" :
	ensure	=> present,
	gid	=> 'adm',
	home 	=> "/home/${openwrt::params::builduser}",
	shell 	=> '/bin/bash',
	}

file { "/home/${openwrt::params::builduser}" :
	ensure	=> directory,
	owner 	=> "${openwrt::params::builduser}",
	require	=> User ["${openwrt::params::builduser}"],
	}

file { "/home/${openwrt::params::builduser}/${openwrt::params::builddir}" :
	ensure	=> directory,
	owner 	=> "${openwrt::params::builduser}",
	require	=> User["${openwrt::params::builduser}"],
	}
	
package { $buildpackages :
	ensure 	=> installed,
	}

}
