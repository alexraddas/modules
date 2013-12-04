class base{

package {['httpd', 'php', 'mysql', 'samba']:
ensure => installed,
}
service { 'httpd':
ensure => running,
require => Package['httpd'],
}
}
