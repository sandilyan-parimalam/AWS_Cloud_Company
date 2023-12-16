variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
}

variable "vpc_name" {
  default = "dev_vpc"
}

variable "web_subnet_cidr_block" {
  default = "10.10.1.0/24"
}

variable "web_subnet_name" {
  default = "dev_web_subnet"
}

variable "web_subnet_1_cidr_block" {
  default = "10.10.2.0/24"
}

variable "web_subnet_1_name" {
  default = "dev_web_1_subnet"
}
variable "web_subnet_az" {
  default = "us-east-1a"
}
variable "web_subnet_1_az" {
  default = "us-east-1b"
}

variable "internet_gateway_name" {
  default = "dev_web_igw"
}

variable "route_table_name" {
  default = "dev_web_rt"
}

variable "route_table_association_name" {
  default = "dev_web_rt_association"
}

variable "security_group_name" {
  default = "dev_web_sg"
}

variable "security_group_description" {
  default = "Security Group for Dev Web environment"
}

variable "http_ingress_description" {
  default = "all http traffic from internet"
}

variable "http_ingress_description" {
  default = "all http traffic from internet"
}

variable "http_ingress_from_port" {
  default = "80"
}

variable "http_ingress_to_port" {
  default = "80"
}

variable "http_ingress_protocol" {
  default = "tcp"
}

variable "http_ingress_cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "any_source_cidr_block" {
  default = "0.0.0.0/0"
}