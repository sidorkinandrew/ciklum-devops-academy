resource "tls_private_key" "sidorkin_deploy" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.sidorkin_deploy.public_key_openssh

  tags = {
    Name = "AWS-RSA-Key-Sidorkin",
    Creator = "Sidorkin"
  }

}

resource "local_file" "sidorkin_deploy_pem" { 
  filename = "${var.key_name}.pem"
  content = tls_private_key.sidorkin_deploy.private_key_pem
  file_permission = 400
}