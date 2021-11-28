resource "local_file" "dockerfile" {
    content  = "FROM wordpress:php7.4-apache\nENV WORDPRESS_DB_HOST=${aws_db_instance.wordpress.endpoint}\nENV WORDPRESS_DB_USER=${var.db_user}\nENV WORDPRESS_DB_PASSWORD=${var.db_password}\nENV WORDPRESS_DB_NAME=${var.db_name}\nCOPY ./html5 /var/www/html/html5"
    filename = "${path.module}/Docker/Dockerfile"
    depends_on = [
	aws_db_instance.wordpress,
    ]
}
