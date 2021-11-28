resource "aws_db_subnet_group" "default" {
    name        = "wp-db-subnet-tf"
    description = "VPC Subnets for RDS"
    subnet_ids  = ["${var.public_subnet_id}", "${var.private_subnet_id}"]
    tags = {
      Name = "for-RDS-WP-MySQL-Sidorkin",
      Creator = "Sidorkin"
    }
}

resource "aws_db_instance" "wordpress" {
    identifier             = "wordpress-rds-db"
    allocated_storage      = 10
    engine                 = "mysql"
    engine_version         = "5.7.34"
    port                   = "3306"
    instance_class         = "${var.db_instance_type}"
    name                   = "${var.db_name}"
    username               = "${var.db_user}"
    password               = "${var.db_password}"
    availability_zone      = "eu-west-1b"
    vpc_security_group_ids = ["${aws_security_group.wp-db-sg.id}"]
    multi_az               = false
    db_subnet_group_name   = "${aws_db_subnet_group.default.id}"
    parameter_group_name   = "default.mysql5.7"
    publicly_accessible    = false
    apply_immediately         = true
    skip_final_snapshot       = true
    backup_retention_period   = 0
    
    tags = {
      Name = "RDS-WP-MySQL-Sidorkin",
      Creator = "Sidorkin"
    }

}