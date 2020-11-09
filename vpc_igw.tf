resource "aws_vpc" "sage_payroll" {
    cidr_block                = "${var.vpc_cidr}"
    instance_tenancy          = "${var.instance_tenancy}"
    enable_dns_hostnames      = true
    enable_dns_support        = true
    enable_nat_gateway        = true 
    enable_vpn_gateway        = true 
    enable_classiclink        = true 

    enable_s3_endpoint        = true 
    enable_dynamodb_endpoint  = true 
    tags = {
        Name                  = "${var.vpc_name}"
    }
}

resource "aws_internet_gateway" "sage_payroll_igw" {
  vpc_id        = "${aws_vpc.sage_payroll.id}"
    tags        = {
        Name    = "${var.vpc_name}_igw"
  }
    depends_on  = ["aws_vpc.sage_payroll"]
}