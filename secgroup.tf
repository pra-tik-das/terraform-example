resource "aws_security_group" "BastionServerSG" {
  name                  = "BastionServerSG"
  description           = "Allow inbound traffic from external networks"
  vpc_id                = "${aws_vpc.sage_payroll.id}"
  tags = {
    Name                = "Bastion Security Group"  
  }
  depends_on            = ["aws_vpc.sage_payroll"]
  ingress {
      from_port         = 3389
      to_port           = 3389
      protocol          = "tcp"
      cidr_blocks       = ["${var.ingress_cidr_bastion}"]
  }
  ingress {
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = ["${var.ingress_cidr_bastion}"]
  }
  ingress {
      from_port         = -1
      to_port           = -1
      protocol          = "icmp"
      cidr_blocks       = ["0.0.0.0/0"]
  }
 egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }
}

/*
resource "aws_security_group" "BastionServerLinuxSG" {
  name                  = "BastionServerLinuxSG"
  description           = "Allow inbound traffic from external networks"
  vpc_id                = "${aws_vpc.sage_payroll.id}"
  tags = {
    Name                = "Bastion Linux Security Group"  
  }
  depends_on            = ["aws_vpc.sage_payroll"]
  ingress {
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = ["${var.ingress_cidr_bastion}"]
  }
  ingress {
      from_port         = -1
      to_port           = -1
      protocol          = "icmp"
      cidr_blocks       = ["${var.ingress_cidr_bastion}"]
  }
 egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }
}
*/

resource "aws_security_group" "AppServerSG" {
  name                  = "AppServerSG"
  description           = "Allow inbound traffic from Bastion host SG"
  vpc_id                = "${aws_vpc.sage_payroll.id}"
  tags = {
    Name                = "App Security Group"  
  }
  depends_on            = ["aws_vpc.sage_payroll"]
  ingress {
      from_port         = 3389
      to_port           = 3389
      protocol          = "tcp"
      security_groups   = ["${aws_security_group.BastionServerSG.id}"]
  }
  ingress {
      from_port         = -1
      to_port           = -1
      protocol          = "icmp"
      security_groups   = ["${aws_security_group.BastionServerSG.id}"]
  }
 egress {
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
  }
}