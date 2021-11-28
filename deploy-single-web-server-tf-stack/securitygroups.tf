resource "aws_security_group" "webserver_sg" { 

   ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "89.64.120.131/32"]
    }

   ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "89.64.120.131/32"]
    }

   egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }    

 tags = {
	 Name = "Sidorkin
 }

}
