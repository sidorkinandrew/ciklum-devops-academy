resource "aws_instance" "jenkins-master" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = "t2.small"
  subnet_id     = var.public_subnet_id
  availability_zone  = "${var.region}a"

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true

  # key name
  key_name  = var.key_name

  user_data = data.template_cloudinit_config.cloudinit-jenkins.rendered

  tags = {
    Name = "jenkins-sidorkin",
    Creator = "Sidorkin"
  }
}

resource "aws_ebs_volume" "jenkins-data" {
  availability_zone = "${var.region}a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "jenkins-data",
    Creator = "Sidorkin"
  }
}

resource "aws_volume_attachment" "jenkins-data-attachment" {
  device_name = var.INSTANCE_DEVICE_NAME
  volume_id   = aws_ebs_volume.jenkins-data.id
  instance_id = aws_instance.jenkins-master.id
}


resource "null_resource" "ssh_key_init" {
    provisioner "local-exec" {
	command = "sleep 41 && cat sidorkin-aws-key.pem | ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ./sidorkin-aws-key.pem ec2-user@${aws_instance.jenkins-master.public_ip} 'sudo cat >/home/ec2-user/temp-key'"
    }
}