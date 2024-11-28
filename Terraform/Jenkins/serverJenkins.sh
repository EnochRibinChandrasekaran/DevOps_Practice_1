#!/usr/bin/bash

echo "Updating logging configuration..."
sudo sh -c "echo '*.info;mail.none;authpriv.none;cron.none /dev/ttyS0' >> /etc/rsyslog.conf"
sudo systemctl restart rsyslog

cd /home/debian
echo "In directory $PWD"

echo "Installing MariaDB..."
sudo apt-get update
sudo apt install -y fontconfig libfreetype6
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
MYSQL_ROOT_USER="root"
MYSQL_ROOT_PASSWORD="comsc"  # Use environment variables or secure methods to handle this

# New user details
BIPSYNC="bipsync"
BIPSYNC_PASSWORD="comsc"     # Use secure handling for passwords

# Log into MySQL and create the new user and grant privileges
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" <<-EOF
CREATE USER '$BIPSYNC'@'localhost' IDENTIFIED BY '$BIPSYNC_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$BIPSYNC'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

echo "User $BIPSYNC created and granted all privileges."
sudo apt-get install wget -y
sudo apt-get install unzip -y
sudo apt-get install git -y

sudo wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb

sudo apt install debconf-utils

dpkg-deb -I jdk-17_linux-x64_bin.deb
dpkg-deb -c jdk-17_linux-x64_bin.deb

echo 'oracle-jdk17-installer shared/accepted-oracle-license-v1-1 select true' | sudo debconf-set-selections

sudo DEBIAN_FRONTEND=noninteractive apt install ./jdk-17_linux-x64_bin.deb

sudo rm jdk-17_linux-x64_bin.deb


echo "Installing Jenkins..."
# sudo wget –q –O – https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add –
# sudo sh -c "echo 'deb https://pkg.jenkins.io/debian-stable binary/' > /etc/apt/sources.list.d/jenkins.list"
sudo apt update
sudo apt install curl -y

sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
sudo echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y

echo "Installing GitLab server key... has to be added to the Jenkins user home (~) dir"
sudo mkdir -p /var/lib/jenkins/.ssh
sudo touch /var/lib/jenkins/.ssh/known_hosts
sudo ssh-keyscan git.cardiff.ac.uk >> /var/lib/jenkins/.ssh/known_hosts
sudo chmod 644 /var/lib/jenkins/.ssh/known_hosts

# If you want Jenkins on port 8081 so you can run your app on 8080 then change the default Jenkins port.
# sudo sed -i 's/HTTP_PORT=8080/HTTP_PORT=8081/g' /etc/default/jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

echo "Installing Gradle..."
wget https://services.gradle.org/distributions/gradle-7.6-bin.zip
sudo mkdir /opt/gradle
sudo unzip -d /opt/gradle gradle-7.6-bin.zip
echo "export PATH=\$PATH:/opt/gradle/gradle-7.6/bin" >> ~/.bashrc
source ~/.bashrc
gradle -v

echo "Installing Terraform..."
cd /home/debian
wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip
unzip terraform_1.1.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/


