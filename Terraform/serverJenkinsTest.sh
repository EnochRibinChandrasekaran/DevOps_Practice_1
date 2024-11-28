#!/usr/bin/bash

echo "Updating logging configuration..."
sudo sh -c "echo '*.info;mail.none;authpriv.none;cron.none /dev/ttyS0' >> /etc/rsyslog.conf"
sudo systemctl restart rsyslog

echo logged in as $USER.
echo in directory $PWD

echo "Installing MariaDB..."
sudo apt-get update
sudo apt-get install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl status mariadb
sudo systemctl enable mariadb

echo "Creating mysql_secure_installation.txt..."
touch mysql_secure_installation.txt
cat << EOF >> mysql_secure_installation.txt
n
Y
comsc
comsc
Y
Y
Y
Y
Y
EOF

echo "Running mysql_secure_installation..."
sudo mysql_secure_installation < mysql_secure_installation.txt
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install wget -y
sudo apt-get install unzip -y
sudo apt-get install git -y

echo "needs to be in root account"
cd root

touch .ssh/known_hosts
ssh-keyscan git.cardiff.ac.uk >> .ssh/known_hosts
chmod 644 .ssh/known_hosts
echo "now needs to be in rocky user directory"
cd /home/debian

cat << `EOF` >> gitlabTakeaway.key
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
`EOF`
chmod 400 gitlabTakeaway.key
sudo ssh-agent bash -c 'ssh-add gitlabTakeaway.key; git clone git@git.cardiff.ac.uk:c23089855/bipsyncapp.git'
cd bipsyncapp 
sudo wget https://services.gradle.org/distributions/gradle-7.6-bin.zip

sudo mysql -u jenkins -pcomsc < src/BuildDB.sql


sudo wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb

sudo apt install debconf-utils

dpkg-deb -I jdk-17_linux-x64_bin.deb
dpkg-deb -c jdk-17_linux-x64_bin.deb

echo 'oracle-jdk17-installer shared/accepted-oracle-license-v1-1 select true' | sudo debconf-set-selections

sudo DEBIAN_FRONTEND=noninteractive apt install ./jdk-17_linux-x64_bin.deb

sudo rm jdk-17_linux-x64_bin.deb

echo "Installing Gradle..."
wget https://services.gradle.org/distributions/gradle-7.6-bin.zip
sudo mkdir /opt/gradle
sudo unzip -d /opt/gradle gradle-7.6-bin.zip
echo "export PATH=\$PATH:/opt/gradle/gradle-7.6/bin" >> ~/.bashrc
source ~/.bashrc
gradle init
gradle -v
gradle build
gradle bootrun




