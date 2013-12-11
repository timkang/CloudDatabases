exec { "apt-update":
   command => "/usr/bin/apt-get update",
   timeout => 0
}

exec { "init_mysql_database":
   command => "/usr/bin/mysql < /home/vagrant/mysql_init_db.mysql",
   require => File['/home/vagrant/mysql_init_db.mysql'],
}

Exec["apt-update"] -> Package <| |>

package {
   "mysql-server":
      ensure => installed
}

file {
   "/etc/version":
      content => "mysql_cluster_01\n"
}

file {
   "/home/vagrant/mysql_init_db.mysql":
   content =>
"USE mysql

GRANT ALL PRIVILEGES ON *.* TO mysql@'192.168.33.14' WITH GRANT OPTION;
FLUSH PRIVILEGES;

DROP DATABASE IF EXISTS ycsb;
CREATE DATABASE ycsb;
USE ycsb;
DROP TABLE IF EXISTS usertable;

CREATE TABLE usertable(YCSB_KEY VARCHAR (255) PRIMARY KEY, FIELD1 TEXT, FIELD2 TEXT, FIELD3 TEXT, FIELD4 TEXT, FIELD5 TEXT, FIELD6 TEXT, FIELD7 TEXT, FIELD8 TEXT, FIELD9 TEXT, FIELD10 TEXT);"
}

file {
   "/etc/hosts":
   content =>
"127.0.0.1 localhost
127.0.0.1 precise64
192.168.33.14 mysql_client
192.168.33.13 mysql_01
192.168.33.15 mysql_02"
}

exec { "copy_my_cnf":
   command => "/bin/cp /vagrant/files/my.cnf /etc/mysql/my.cnf"
}