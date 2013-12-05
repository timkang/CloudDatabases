exec { "dist-upgrade":
   environment => ["DEBIAN_FRONTEND=noninteractive"],
   command => "/usr/bin/apt-get -y -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confold\" dist-upgrade",
   timeout => 0
}

exec { "apt-update":    
   command => "/usr/bin/apt-get update",
   timeout => 0
}

Exec["apt-update"] -> Exec["dist-upgrade"] -> Package <| |>

package {
   "mongodb":
      ensure => installed
}
