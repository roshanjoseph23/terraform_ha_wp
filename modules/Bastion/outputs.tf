output "aws_instance_bastionserver_public_ip" {
    value = aws_instance.bastionserver.public_ip
}

output "aws_instance_bastionserver_public_dns" {
    value = aws_instance.bastionserver.public_dns
}