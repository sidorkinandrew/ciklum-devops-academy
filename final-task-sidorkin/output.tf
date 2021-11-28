output "dns_name_ALB_application" {
    value = "${aws_lb.default.dns_name}"
}


output "dns_name_ALB_jenkins" {
    value = "${aws_lb.default.dns_name}"
}


output "certificate_ACM_id" {
  value = "${aws_acm_certificate.application.id}"
}


output "rds_endpoint" {
   value = "${aws_db_instance.wordpress.endpoint}"
}


output "app_repository_URL" {
  value = aws_ecr_repository.app-sidorkin.repository_url
}


output "application_domain_name" {
  value = "${aws_route53_record.application.fqdn}"
}


output "jenkins_domain_name" {
  value = "${aws_route53_record.application.fqdn}"
}


output "ec2_app_public_ip" {
  value = aws_instance.ec2_wp.public_ip # aws_eip_association.eip_assoc.public_ip
}


output "jenkins_public_ip" {
  value = aws_instance.jenkins-master.public_ip
}

