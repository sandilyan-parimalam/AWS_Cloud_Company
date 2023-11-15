variable "my_current_region" {
  type    = string
  default = null
}
variable "dev_web_eks_iam_role" {
  default = "dev_web_eks_iam_role"
}
variable "dev_web_eks_iam_policy_attachment" {
  default = "dev_web_eks_iam_policy_attachment"
}
variable "dev_web_eks_iam_policy_attachment1" {
  default = "dev_web_eks_iam_policy_attachment1"

}
variable "dev_web_eks_node_iam_role" {
  default = "dev_web_eks_node_iam_role"

}
variable "dev_web_eks_node_iam_policy_attachment" {
  default = "dev_web_eks_node_iam_policy_attachment"
}
variable "dev_web_eks_node_iam_policy_attachment1" {
  default = "dev_web_eks_node_iam_policy_attachment1"
}
variable "dev_web_eks_node_iam_policy_attachment2" {
  default = "dev_web_eks_node_iam_policy_attachment2"
}
variable "dev_web_eks_node_iam_policy_attachment3" {
  default = "dev_web_eks_node_iam_policy_attachment3"
}

variable "dev_web_eks_cluster" {
  default = "dev_web_eks_cluster"
}

variable "dev_web_eks_node_group" {
  default = "dev_web_eks_node_group"
}



variable "web_server_instance_ami" {
  default = "ami-05c13eab67c5d8861"
}

variable "web_server_instance_type" {
  default = "t2.micro"
}


variable "web_server_instance_key_name" {
  default = "dev_web_keypair"
}

variable "web_server_instance_tags" {
  default = {
    Name = "DLW01"
  }
}
