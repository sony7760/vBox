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
  image     = "ubuntu-22.04-live-server-amd64.ovf"
  cpus      = 1
  memory    = "4096 mib"
  #user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet1"
  }
}

resource "virtualbox_vm" "node" {
  count     = 2
  name      = "k8s-node-${count.index + 1}"
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 1
  memory    = "2048 mib"
  #user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet1"
  }
}

output "Master-IPAddress-1" {
  value = element(virtualbox_vm.master.*.network_adapter.0.ipv4_address, 1)
}

output "Node-IPAddress-1" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}

output "Node-IPAddress-2" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
}
