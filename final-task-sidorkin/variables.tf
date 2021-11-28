variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0f3dcd0687f11db21"
}

variable "my_dns_name" {
  type = string
  default = "sidorkin"
}

variable "jenkins_dns_name" {
  type = string
  default = "jenkins"
}

variable "vpc_cidr_block" {
  description = "VPC Academy CIDR block"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_block" {
  description = "Public Subnet Sidorkin"
  default     = "10.0.13.0/24"
}

variable "public_subnet_cidr_block" {
  description = "Private Subnet Sidorkin"
  default     = "10.0.33.0/24"
}

variable "private_subnet_id" {
  type    = string
  default = "subnet-04723641d99df1ff9"
}

variable "public_subnet_id" {
  type    = string
  default = "subnet-0835b6caa6509e9b9"
}

variable "ami_id" {
  type = map(any)
  default = {
    eu-west-1    = "ami-0d1bf5b68307103c2"
    eu-west-2    = "ami-132b3c7efe6sdfdsfd"
    eu-central-1 = "ami-9787h5h6nsn75gd33"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "TERRAFORM_VER" {
  default = "1.0.6"
}


variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "sidorkin-aws-key"
}

variable "db_instance_type" {
  description = "RDS instance type"
  default = "db.t2.micro"
}

variable "db_name" {
  description = "RDS DB name"
  default = "wordpressdb"
}

variable "db_user" {
  description = "RDS DB username"
  default = "wpawsrdsdb"
}

variable "db_password" {
  description = "RDS DB password"
  default = "Qwer#$%12345-"
  # generate a random password here
}

variable "wp_title" {
  description = "Wordpress title"
  default = "Wordpress Instance (Sidorkin)"
}

variable "wp_user" {
  description = "Wordpress username"
  default = "adminwordpressa"
}

variable "wp_password" {
  description = "Wordpress password"
  default = "Qwerty#$%12345-"
}

variable "wp_mail" {
  description = "Wordpress email"
  default = "qwerty@qwerty.com"
}