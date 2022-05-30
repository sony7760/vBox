terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

provider "virtualbox" {
  # Configuration options
}

resource "virtualbox_vm" "master" {
  name      = "k8s-master"
  #image     = "../AMI/vagrant-images/package.box"
  #image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20220523.0.0/providers/virtualbox.box"
  cpus      = 1
  memory    = "4096 mib"
  
  #network_adapter {
  #  type           = "nat"
  #}
  connection {
    type = "ssh"
    user = "vagrant"
    password = "vagrant"
    host = element(virtualbox_vm.master.*.network_adapter.0.ipv4_address, 1)
  }
  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet1"
  }
  provisioner "file" {
    source      = "scripts/test.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "ls -l /tmp/script.sh",
      "chmod +x /tmp/script.sh",
    ]
  }
}

resource "virtualbox_vm" "node" {
  count     = 2
  name      = "k8s-node${count.index + 1}"
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 1
  memory    = "2048 mib"

  #network_adapter {
  #  type           = "nat"
  #}
  
  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet1"
  }
}

output "Master-IPAddress-1" {
  value = element(virtualbox_vm.master.*.network_adapter.0.ipv4_address, 1)
}

#output "Node-IPAddress-1" {
#  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
#}

#output "Node-IPAddress-2" {
#  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
#}
