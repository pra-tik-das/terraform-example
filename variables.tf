variable "aws_region" {
    type        = string
    description = "This is the AWS Region to create the Terraform resources"
    }

variable "iam_profile" {
    type        = string
    description = "This is the IAM user profile to create Terraform Resources"
    }

variable "vpc_name" {
    type        = string
    description = "This variable is to assign the name to default VPC"
}

variable "vpc_cidr" {
    type        = string
    description = "This is the CIDR block for VPC"
}

variable "instance_tenancy"{
    type        = string
    description = "This variable defines the instance tenancy in the VPC"
}

variable "instance_type" {
    type        = string
    description = "This variable sets the AWS EC2 Instance Type"
}

variable "ingress_cidr_bastion" {
    type        = string
    description = "This is the CIDR range of external traffic to bastion host"
}

variable "public_subnet_cidr" {
    type        = string
    description = "This is the CIDR block for VPC Public Subnet" 
}

variable "app_subnet_cidr" {
    type        = string 
    description = "This is the CIDR block for VPC App Subnet"
}

variable "db_subnet_cidr" {
    type        = string 
    description = "This is the CIDR block for VPC DB Subnet"
}

variable "subnet_cidrs_private" {
  description   = "Subnet CIDRs for private subnets"
  default       = ["10.0.10.0/24","10.0.100.0/24"]
  type          = list
}

variable "private_name" {
    description = "name of private subnets"
    type        = map 
    default     = {
        "0"     = "app"
        "1"     = "db"
    }
}
