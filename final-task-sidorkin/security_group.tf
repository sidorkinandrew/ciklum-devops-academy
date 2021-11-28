resource "aws_security_group" "application-sg" {
  name        = "application-security_group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    # SSH Port 22 allowed from my IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["89.64.120.131/32"]
  }

  ingress {
    # SSH Port 22 allowed from Jenkins
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.jenkins-sg.id}"]
  }

  ingress {
    # SSH Port 80 allowed from ALB
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.wp-elb.id}"]
  }

  ingress {
    # SSH Port 443 allowed from ALB
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = ["${aws_security_group.wp-elb.id}"]
  }

  egress {
    # outbound to any IP
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-SSH-HTTP-Sidorkin",
    Creator = "Sidorkin"
  }
}


resource "aws_security_group" "wp-db-sg" {
  name        = "rds-db-app-security_group"
  description = "Access to the RDS instances from the VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["${aws_security_group.application-sg.id}"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    security_groups = ["${aws_security_group.application-sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-RDS-APP-Sidorkin",
    Creator = "Sidorkin"
  }
}



resource "aws_security_group" "wp-elb" {
  name        = "wp-elb-security_group"
  description = "Security Group for ELB/WP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-HTTP/S-Sidorkin",
    Creator = "Sidorkin"
  }
}


resource "aws_security_group" "jenkins-sg" {
  vpc_id      = var.vpc_id
  name        = "jenkins-securitygroup"
  description = "security group that allows ssh and all egress traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["89.64.120.131/32"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = ["${aws_security_group.wp-elb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Jenkins-SSH-HTTP-Sidorkin",
    Creator = "Sidorkin"
  }
}