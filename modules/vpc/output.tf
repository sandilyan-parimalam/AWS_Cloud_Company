output "dev_web_region" {
  value = var.region
}

output "dev_web_subnet_id" {
  value = aws_subnet.dev_web_subnet.id
}

output "dev_web_subnet_1_id" {
  value = aws_subnet.dev_web_subnet_1.id
}
