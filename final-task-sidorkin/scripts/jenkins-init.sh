#!/bin/bash
# volume setup
sudo vgchange -ay
DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  # wait for the device to be attached
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done
  pvcreate ${DEVICE}
  vgcreate data ${DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume1
fi
sudo mkdir -p /var/lib/jenkins
sudo echo '/dev/data/volume1 /var/lib/jenkins ext4 defaults 0 0' >> /etc/fstab
sudo mount /var/lib/jenkins
# setup docker/apache
sudo yum update -y
sudo yum -y install curl wget unzip git awscli aws-cfn-bootstrap mc htop nfs-utils chrony conntrack jq ec2-instance-connect socat
sudo yum install -y mysql httpd
sudo amazon-linux-extras enable docker
sudo yum clean metadata
sudo amazon-linux-extras install epel docker java-openjdk11 python3.8 -y
sudo systemctl enable --now docker
# newgrp docker
sudo service docker start
# install pip/awscli
#wget -q https://bootstrap.pypa.io/get-pip.py
#python3 get-pip.py
#rm -f get-pip.py
#wget -q https://bootstrap.pypa.io/pip/2.7/get-pip.py
#python get-pip.py
#rm -f get-pip.py
#python -m pip install awscli
#python3 -m pip install awscli
# install jenkins
sudo yum update
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo usermod -G docker jenkins
sudo service jenkins restart
sudo systemctl enable jenkins
# cat /var/lib/jenkins/secrets/initialAdminPassword
# add GitLab/AWS creds
# adding the internal IP of the host to ssh into from jenkins
APP_HOST="${AWS_APP_HOST}"
sudo echo "$APP_HOST" >/var/lib/jenkins/app_hostip_private
sudo chown jenkins /var/lib/jenkins/app_hostip_private
sudo chgrp jenkins /var/lib/jenkins/app_hostip_private
export AWS_APP_HOST=`cat /var/lib/jenkins/app_hostip_private`
echo """sudo mkdir /var/lib/jenkins/.ssh
sudo ssh-keygen -b 4096 -t rsa -f /var/lib/jenkins/.ssh/ec2_rsa -q -N ''
sudo chmod 400 /var/lib/jenkins/.ssh/ec2_rsa
sudo chmod 400 /home/ec2-user/temp-key
sudo cat /var/lib/jenkins/.ssh/ec2_rsa.pub | ssh -i ./temp-key ec2-user@$APP_HOST 'cat >> ~/.ssh/authorized_keys'
sudo chown jenkins /var/lib/jenkins/.ssh/*
sudo chgrp jenkins /var/lib/jenkins/.ssh/*
sudo rm -f /home/ec2-user/temp-key
sudo rm -f /home/ec2-user/ssh_init.sh""">/home/ec2-user/ssh_init.sh
