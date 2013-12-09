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

Exec["apt-update"] -> Package <| |> -> Exec["copy_ycsb"] -> Exec["install_ycsb"]

package {
  "maven":
    ensure => installed
}

package {
  "openjdk-7-jdk":
    ensure => installed
}

package {
   "mongodb":
      ensure => installed
}

file {
   "/home/vagrant/start_mongos.sh":
      content => "sudo mongos --configdb cfg_server:27017 --port 27018 --chunkSize 1",
      mode => 0777
}

file {
   "/etc/hosts":
   content =>
"127.0.0.1 localhost
127.0.0.1 precise64
192.168.33.10 cfg_server
192.168.33.11 shard_01
192.168.33.12 shard_02"
}

file {
   "/etc/version":
      content => "mongodb_config_server\n"
}

file {
  "/etc/mongodb.conf":
   content =>
"# mongodb.conf

# Where to store the data.
dbpath=/var/lib/mongodb

#where to log
#logpath=/var/log/mongodb/mongodb.log
#logappend=true

port = 27017
configsvr = true

# Enable journaling, http://www.mongodb.org/display/DOCS/Journaling
journal=true"
}
