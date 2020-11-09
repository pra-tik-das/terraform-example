/*
data "aws_ami" "windows" {
  most_recent                   = true 
  owners                        = ["649711108397"]
  filter {
       name                     = "name"
       values                   = ["Microsoft Windows Server 2019 *"]  
  }     
  filter {
       name                     = "virtualization-type"
       values                   = ["hvm"]  
  }     
}
*/

resource "aws_instance" "bastion_host" {
  
  subnet_id                     = "${aws_subnet.sage_payroll_public_subnet.id}"
  vpc_security_group_ids        = ["${aws_security_group.BastionServerSG.id}"]
  ami                           = "ami-024c2d542738e461b"
  instance_type                 = "${var.instance_type}"
  tenancy                       = "${var.instance_tenancy}"
  associate_public_ip_address   = true
  source_dest_check             = false
            tags = {
                Name            = "Bastion_Host"
                }
  key_name                      = "sage-payroll"
  get_password_data             = true

}

/*
resource "aws_instance" "bastion_linux_host" {
  
  subnet_id                     = "${aws_subnet.sage_payroll_public_subnet.id}"
  vpc_security_group_ids        = ["${aws_security_group.BastionServerSG.id}"]
  ami                           = "ami-0528a5175983e7f28"
  instance_type                 = "t2.micro"
  tenancy                       = "default"
  associate_public_ip_address   = true
  source_dest_check             = false
            tags = {
                Name            = "Bastion_Linux_Host"
                }
  key_name                      = "sage-payroll"
  
}
*/

resource "aws_instance" "app_server" {
  
  subnet_id                     = "${aws_subnet.private[0].id}"
  vpc_security_group_ids        = ["${aws_security_group.AppServerSG.id}"]
  ami                           = "ami-024c2d542738e461b"
  instance_type                 = "${var.instance_type}"
  tenancy                       = "${var.instance_tenancy}"
  associate_public_ip_address   = false 
  source_dest_check             = false
            tags = {
                Name            = "App_Server"
                }
  key_name                      = "sage-payroll"
  get_password_data             = true

}