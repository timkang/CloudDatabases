exec { "apt-update":
  command => "/usr/bin/apt-get update",
  timeout => 0
}

exec { "copy_ycsb":
  command => "/bin/cp -r /vagrant/files/YCSB /home/vagrant/",
  timeout => 0
}

exec { "install_ycsb":
  cwd => "/home/vagrant/YCSB",
  command => "/usr/bin/mvn package",
  timeout => 0
}

file {
   "/etc/version":
      content => "mysql_client\n"
}

Exec["apt-update"] -> Package <| |> -> Exec["copy_ycsb"] -> Exec["install_ycsb"]

package {
  "maven":
    ensure => installed
}

package {
  "openjdk-7-jdk":
    ensure => installed
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