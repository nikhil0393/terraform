output "aws_security_group_http_server_details" {
  value = aws_security_group.http_server_sg
}

output "aws_instance_details" {
  value = aws_instance.http_servers
}

output "http_server_public-dns" {
  value = values(aws_instance.http_servers).*.id
}

output "elb_public_dns" {
  value = aws_elb.elb
}