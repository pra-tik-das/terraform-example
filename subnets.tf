resource "aws_subnet" "sage_payroll_public_subnet" {
    vpc_id                      = "${aws_vpc.sage_payroll.id}"
    cidr_block                  = "${var.public_subnet_cidr}"
    map_public_ip_on_launch     = true 

    tags = {
        Name                    = "${var.vpc_name}_public_subnet"
    }
depends_on = ["aws_vpc.sage_payroll"]
}

resource "aws_subnet" "private" {
    count                       = "${length(var.subnet_cidrs_private)}"
    vpc_id                      = "${aws_vpc.sage_payroll.id}"
    cidr_block                  = "${var.subnet_cidrs_private[count.index]}"
    map_public_ip_on_launch     = false

    tags = {
        count                   = "${length(var.subnet_cidrs_private)}"
        Name                    = "${var.vpc_name}_${lookup(var.private_name, count.index)}_subnet"
    } 
depends_on                      = ["aws_vpc.sage_payroll"]
}