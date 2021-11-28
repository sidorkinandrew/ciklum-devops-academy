#! /bin/bash
sudo yum update -y
sudo yum install -y mysql wget mc htop
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install -y docker
sudo yum clean metadata
sudo service docker start
sudo systemctl enable docker
sudo usermod -G docker ec2-user

# DB config one-liner
sudo mysql -h ${RDS_ADDRESS} -u ${DB_USER} -p${DB_PASSWORD} ${DB_NAME} --execute="CREATE USER '${DB_USER}' IDENTIFIED BY '${DB_PASSWORD}'; GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER}; FLUSH PRIVILEGES;"

# curl https://api.wordpress.org/secret-key/1.1/salt/
cd /home/ec2-user
# create dockerfile to start with
echo """FROM wordpress:php7.4-apache
ENV WORDPRESS_DB_HOST=${RDS_ENDPOINT}
ENV WORDPRESS_DB_USER=${DB_USER}
ENV WORDPRESS_DB_PASSWORD=${DB_PASSWORD}
ENV WORDPRESS_DB_NAME=${DB_NAME}
""">/home/ec2-user/Dockerfile

# reqiured to start aws cli with env creds
mkdir /home/ec2-user/.aws
sudo mkdir /root/.aws
echo """[default]
source_profile = default
credential_source = Environment""">/home/ec2-user/.aws/config
sudo cp /home/ec2-user/.aws/config /root/.aws/

# snippet to restart/cleanup the image
echo """docker stop \$(docker ps -aq)
docker rm \$(docker ps -aq)
docker rmi \$(docker images -a | grep -i none | awk -F\" \" '{ print \$3 }')""">./restart_app.sh
chmod +x ./restart_app.sh

sudo docker build -t '${REPO_NAME}' .
sudo docker run --name ${REPO_NAME} -p 80:80 -p 443:80 -d ${REPO_NAME}
