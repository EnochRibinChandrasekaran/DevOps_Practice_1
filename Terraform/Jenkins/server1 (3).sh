#!/bin/bash

echo "cd to root directory..."
cd root

echo "whoami..."
whoami

echo "pwd..."
pwd

echo "update logging configuration..."
sudo sh -c "echo '*.info;mail.none;authpriv.none;cron.none /dev/ttyS0' >> /etc/rsyslog.conf"
sudo systemctl restart rsyslog

# commented out to speed things up, do not do this in production
# echo "upgrading..."
# sudo yum upgrade -y

sudo yum install git -y
sudo yum install wget -y
sudo yum install java-17-openjdk-devel -y

# https://www.jenkins.io/doc/book/installing/linux/#red-hat-centos
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword