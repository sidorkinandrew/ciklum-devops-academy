data "template_file" "jenkins-init" {
  template = file("scripts/jenkins-init.sh")
  vars = {
    DEVICE          = var.INSTANCE_DEVICE_NAME,
    TERRAFORM_VER   = var.TERRAFORM_VER,
    AWS_APP_HOST    = "${aws_instance.ec2_wp.private_ip}"
  }
}

data "template_cloudinit_config" "cloudinit-jenkins" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.jenkins-init.rendered
  }
}

data "template_file" "wp-init" {
  template = file("scripts/wp-init.sh")
  vars = {
    RDS_ENDPOINT    = "${aws_db_instance.wordpress.endpoint}",
    DB_NAME         = var.db_name,
    DB_USER         = var.db_user,
    DB_PASSWORD     = var.db_password,
    RDS_ADDRESS     = "${aws_db_instance.wordpress.address}",
    REPO_NAME       = "app-sidorkin"
  }
}

data "template_cloudinit_config" "cloudinit-wp" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.wp-init.rendered
  }
}

