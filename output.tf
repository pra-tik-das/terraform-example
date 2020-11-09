output "vpc_id" {
    value   = aws_vpc.sage_payroll.id
}

output "bastion_public_ip" {
    value   = aws_instance.bastion_host.public_ip 
}

output "app_server_private_ip" {
    value   = aws_instance.app_server.private_ip
}

