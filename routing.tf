resource "aws_route_table" "public_rt" {
  vpc_id                    = "${aws_vpc.sage_payroll.id}"
    route {
      cidr_block            = "0.0.0.0/0"
      gateway_id            = "${aws_internet_gateway.sage_payroll_igw.id}"
    }
    tags = {
        Name                = "Sage Payroll Public Route Table"
    }
    depends_on              = ["aws_vpc.sage_payroll", "aws_internet_gateway.sage_payroll_igw"]
}

resource "aws_route_table_association" "public" {
  route_table_id            = "${aws_route_table.public_rt.id}"
  subnet_id                 = "${aws_subnet.sage_payroll_public_subnet.id}"
  depends_on                = ["aws_route_table.public_rt", "aws_subnet.sage_payroll_public_subnet", "aws_internet_gateway.sage_payroll_igw"]
}

resource "aws_route_table" "private_rt" {
  vpc_id                    = "${aws_vpc.sage_payroll.id}"
    /*
    route {
      cidr_block            = "0.0.0.0/0"
      gateway_id            = "${aws_internet_gateway.sage_payroll_igw.id}"
    }
    */
    tags = {
        Name                = "Sage Payroll Private Route Table"
    }
    depends_on              = ["aws_vpc.sage_payroll"]
}

resource "aws_route_table_association" "private" {
  count                     = "${length(var.subnet_cidrs_private)}"
  route_table_id            = "${aws_route_table.private_rt.id}"
  subnet_id                 = "${element(aws_subnet.private.*.id, count.index)}"
  /*
  depends_on                = ["aws_route_table.private_rt", "aws_subnet.sage_payroll_app_subnet", "aws_subnet.sage_payroll_db_subnet" ]
  */
}