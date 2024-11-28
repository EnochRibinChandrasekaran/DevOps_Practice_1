variable "flavor" { default = "m1.medium" }

variable "image" { default = "Debian 12 Bookworm" }

variable "name" { default = "JenkinsServer" }

variable "network" { default = "scmimc_network" }   

variable "keypair" { default = "openstack_keypair" } 

variable "pool" { default = "cscloud_private_floating" }

variable "server_script" { default = "./serverJenkins.sh" }

variable "security_description" { default = "Terraform security group" }

variable "security_name" { default = "tf_security" }

