resource "aws_instance" "ec2_wp" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  availability_zone  = "${var.region}a" 

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.application-sg.id]
  associate_public_ip_address = true

  # key name
  key_name  = var.key_name
  # user_data = file("wp_config.sh")
  user_data = data.template_cloudinit_config.cloudinit-wp.rendered

  tags = {
    Name = "application-Sidorkin",
    Creator = "Sidorkin"
  }
}
