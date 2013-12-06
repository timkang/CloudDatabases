exec { "dist-upgrade":
   environment => ["DEBIAN_FRONTEND=noninteractive"],
   command => "/usr/bin/apt-get -y -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confold\" dist-upgrade",
   timeout => 0
}

exec { "apt-update":    
  command => "/usr/bin/apt-get update",
  timeout => 0
}

exec { "copy_ycsb":    
  command => "/bin/cp -r /vagrant/YCSB /home/vagrant/",
  timeout => 0
}

exec { "install_ycsb":
  cwd => "/home/vagrant/YCSB",
  command => "/usr/bin/mvn package clean",
  timeout => 0
}

Exec["apt-update"] -> Exec["dist-upgrade"] -> Package <| |> -> Exec["copy_ycsb"] -> Exec["install_ycsb"]

package {
   "git":
      ensure => installed
}

package {
  "maven":
    ensure => installed
}

package {
  "openjdk-7-jdk":
    ensure => installed
}
