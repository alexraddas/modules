class test{
package {httpd :
	ensure => present,
}
user { araddas :
	ensure => present,
	gid => adm,
	home => '/home/araddas',
}
file {'/depot/list' :
	ensure => file,
	owner => araddas,
	mode => 0777,
}
}
