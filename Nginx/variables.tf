variable "flavor" { default = "m1.small" }

variable "image" { default = "Debian 12 Bookworm" }

variable "name" { default = "Nginserver" }

variable "network" { default = "scmimc_network" }  

variable "keypair" { default = "openstack_keypair" } 

variable "pool" { default = "cscloud_private_floating" }

variable "server_script" { default = "./serverJenkinsTest.sh" }

variable "security_description" { default = "Terraform security group" }

variable "security_name" { default = "nginx" }
