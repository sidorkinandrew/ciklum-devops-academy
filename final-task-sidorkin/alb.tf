# App ALB
resource "aws_lb" "default" {
    name               = "alb-sidorkin"
    enable_http2       = "true"
    internal           = "false"
    ip_address_type    = "ipv4"
    load_balancer_type = "application"
    security_groups    = ["${aws_security_group.wp-elb.id}"]
    subnets            = ["${var.public_subnet_id}", "${var.private_subnet_id}"]
    tags = {
        Creator = "Sidorkin",
        Name    = "alb-app-sidorkin"
    }
}

# App HTTP redirecto-forwarder
resource "aws_lb_listener" "app-https-force"{
    default_action {
      order = "1"
        redirect {
            host        = "${var.my_dns_name}.${data.aws_route53_zone.public.name}"  # "sidorkin.ciklum-devops-academy.org"
            path        = "/#{path}"
            port        = "443"
            protocol    = "HTTPS"
            query       = "#{query}"
            status_code = "HTTP_301"
        }

        type = "redirect"
    }
 

    load_balancer_arn = "${aws_lb.default.arn}"
    port              = "80"
    protocol          = "HTTP"

    tags = {
        Creator = "Sidorkin"
    }
}

# App HTTPS/SSL listener
resource "aws_lb_listener" "app-https" {
    certificate_arn = "${aws_acm_certificate.application.arn}"

    default_action {
        order            = "1"
        target_group_arn = "${aws_lb_target_group.alb-tg-application.arn}"  # target group application
        type             = "forward"
    }

    load_balancer_arn = "${aws_lb.default.arn}"
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"

    tags = {
        Creator = "Sidorkin"
    }
}

# App TG group
resource "aws_lb_target_group" "alb-tg-application" {
    deregistration_delay = "300"

    health_check {
        enabled             = "true"
        healthy_threshold   = "5"
        interval            = "30"
        matcher             = "200"
        path                = "/readme.html"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
        unhealthy_threshold = "2"
    }

    load_balancing_algorithm_type = "round_robin"
    name                          = "tg-app-sidorkin"
    port                          = "80"
    protocol                      = "HTTP"
    protocol_version              = "HTTP1"

    stickiness {
        cookie_duration = "86400"
        enabled         = "false"
        type            = "lb_cookie"
    }

    tags = {
        Creator = "Sidorkin",
        Name    = "tg-app-sidorkin"
    }

    target_type = "instance"
    vpc_id      = var.vpc_id
}


# ALB for Jenkins
resource "aws_lb" "jenkins" {
    name               = "alb-jenkins-sidorkin"
    enable_http2       = "true"
    internal           = "false"
    ip_address_type    = "ipv4"
    load_balancer_type = "application"
    security_groups    = ["${aws_security_group.wp-elb.id}"]
    subnets            = ["${var.public_subnet_id}", "${var.private_subnet_id}"]
    tags = {
        Creator = "Sidorkin",
        Name    = "alb-jenkins-sidorkin"
    }
}

# Jenkins HTTP-to-HTTPS forwarder-listener
resource "aws_lb_listener" "jenkins-https-force"{
    default_action {
      order = "1"
        redirect {
            host        = "${var.jenkins_dns_name}.${var.my_dns_name}.${data.aws_route53_zone.public.name}"  # "sidorkin.ciklum-devops-academy.org"
            path        = "/#{path}"
            port        = "443"
            protocol    = "HTTPS"
            query       = "#{query}"
            status_code = "HTTP_301"
        }

        type = "redirect"
    }
 

    load_balancer_arn = "${aws_lb.jenkins.arn}"
    port              = "80"
    protocol          = "HTTP"

    tags = {
        Creator = "Sidorkin"
    }
}


# Jenkins HTTPS listener
resource "aws_lb_listener" "jenkins"{
    certificate_arn = "${aws_acm_certificate.application.arn}"

    default_action {
      order            = "1"
      target_group_arn = "${aws_lb_target_group.alb-tg-jenkins.arn}"  # jenkins target group
      type             = "forward"
    }

    load_balancer_arn = "${aws_lb.jenkins.arn}"
    port              = "443"
    protocol          = "HTTPS"  # 8443
    ssl_policy        = "ELBSecurityPolicy-2016-08"

    tags = {
        Creator = "Sidorkin"
    }
}


# Jenkins TG group
resource "aws_lb_target_group" "alb-tg-jenkins" {
    deregistration_delay = "300"

    health_check {
        enabled             = "true"
        healthy_threshold   = "5"
        interval            = "30"
        matcher             = "200"
        path                = "/login"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
        unhealthy_threshold = "2"
    }

    load_balancing_algorithm_type = "round_robin"
    name                          = "tg-jenkins-sidorkin"
    port                          = "8080"
    protocol                      = "HTTP"
    protocol_version              = "HTTP1"

    stickiness {
        cookie_duration = "86400"
        enabled         = "false"
        type            = "lb_cookie"
    }

    tags = {
        Creator = "Sidorkin",
        Name    = "tg-jenkins-sidorkin"
    }
    target_type = "instance"
    vpc_id      = var.vpc_id
}


resource "aws_lb_target_group_attachment" "attach-jenkins" {
    target_group_arn = "${aws_lb_target_group.alb-tg-jenkins.arn}"
    target_id        = "${aws_instance.jenkins-master.id}"
}

resource "aws_lb_target_group_attachment" "attach-application" {
    target_group_arn = "${aws_lb_target_group.alb-tg-application.arn}"
    target_id        = "${aws_instance.ec2_wp.id}"
}
