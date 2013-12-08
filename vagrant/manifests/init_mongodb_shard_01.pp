exec { "apt-update":    
   command => "/usr/bin/apt-get update",
   timeout => 0
}

Exec["apt-update"] -> Package <| |>

package {
   "mongodb":
      ensure => installed
}

file {
   "/home/vagrant/start_mongo.sh":
      content => "sudo mongo --host cfg_server --port 27018",
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
      content => "mongodb_shard_01\n"
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
shardsvr = true

# Enable journaling, http://www.mongodb.org/display/DOCS/Journaling
journal=true"
}