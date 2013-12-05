exec { "apt-update":    
  command => "/usr/bin/apt-get update",
    timeout => 0
}

Exec["apt-update"] -> Package <| |> -> Exec["install_vb_guest" -> Exec["copy_ycsb"]

package {
  "mongodb":
    ensure => installed
}

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

exec {"install_vb_guest":
  command => "sudo apt-get install dkms -y && wget http://download.virtualbox.org/virtualbox/4.2.16/VBoxGuestAdditions_4.2.16.iso && sudo mkdir /mnt/guest && sudo mount -o loop VBoxGuestAdditions_4.2.16.iso /mnt/guest && /mnt/guess/VBoxLinuxAdditions.run"}

exec {"copy_ycsb":
  command => "/bin/cp -r /vagrant/YCSB /home/vagrant"}