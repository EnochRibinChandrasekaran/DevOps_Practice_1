# #!/bin/bash

# # Ensure the script is run as root
# if [ "$(id -u)" != "0" ]; then
#    echo "This script must be run as root" 1>&2
#    exit 1
# fi

# # Update and upgrade packages
# sudo apt-get update && sudo apt-get upgrade -y

# # # Install Java OpenJDK 11 for SonarQube
# # sudo apt-get install -y openjdk-11-jdk
# sudo apt install jq -y
# sudo apt install curl -y
# sudo apt install tar -y
# sudo apt install wget -y

# sudo wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb

# sudo apt install debconf-utils

# dpkg-deb -I jdk-17_linux-x64_bin.deb
# dpkg-deb -c jdk-17_linux-x64_bin.deb

# echo 'oracle-jdk17-installer shared/accepted-oracle-license-v1-1 select true' | sudo debconf-set-selections

# sudo DEBIAN_FRONTEND=noninteractive apt install ./jdk-17_linux-x64_bin.deb

# sudo rm jdk-17_linux-x64_bin.deb

# echo "Installing MariaDB..."
# sudo apt-get update
# sudo apt-get install mariadb-server -y
# sudo systemctl start mariadb
# sudo systemctl status mariadb
# sudo systemctl enable mariadb

# echo "Creating mysql_secure_installation.txt..."
# touch mysql_secure_installation.txt
# cat << EOF >> mysql_secure_installation.txt
# n
# Y
# comsc
# comsc
# Y
# Y
# Y
# Y
# Y
# EOF

# echo "Running mysql_secure_installation..."
# sudo mysql_secure_installation < mysql_secure_installation.txt

# URL="https://dlm.mariadb.com/3752059/Connectors/java/connector-java-3.3.3/mariadb-connector-j-3.3.3.tar.gz"
# DESTINATION="/usr/share/java"

# TEMP_DIR=$(mktemp -d)
# echo "Temporary directory created at: $TEMP_DIR"

# cd $TEMP_DIR

# echo "Downloading MariaDB Connector/J..."
# curl -LO $URL

# echo "Extracting the file..."
# tar -xzf mariadb-connector-j-3.3.3.tar.gz

# JAR_FILE=$(find . -name '*.jar' | head -n 1)

# echo "Installing the connector to $DESTINATION..."
# sudo mkdir -p $DESTINATION
# sudo cp $JAR_FILE $DESTINATION

# echo "Cleaning up..."
# cd ..
# rm -rf $TEMP_DIR

# sudo wget -O jfrog-deb-installer.tar.gz "https://releases.jfrog.io/artifactory/jfrog-prox/org/artifactory/pro/deb/jfrog-platform-trial-prox/[RELEASE]/jfrog-platform-trial-prox-[RELEASE]-deb.tar.gz"

# sudo tar -xvzf jfrog-deb-installer.tar.gz

# sudo rm jfrog-deb-installer.tar.gz

# cd jfrog-platform-trial-pro*

# sudo ./install.sh

# cd /

# JFROG_HOME="/opt/jfrog" 

# DB_NAME="artdb"
# DB_USER="artifactory"
# DB_PASSWORD="password"
# DB_HOST="127.0.1.1:3306"

# URL="https://dlm.mariadb.com/3752059/Connectors/java/connector-java-3.3.3/mariadb-connector-j-3.3.3.tar.gz"
# FILENAME="mariadb-connector-j-3.3.3.tar.gz"

# TARGET_DIR="$JFROG_HOME/artifactory/var/bootstrap/artifactory/tomcat/lib"

# SYSTEM_YAML="$JFROG_HOME/artifactory/var/etc/system.yaml"

# MYSQL_CONF="/etc/my.cnf"

# mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_bin;"
# mysql -u root -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD'; FLUSH PRIVILEGES;"

# wget $URL -O $FILENAME

# tar -zxvf $FILENAME
# JAR_FILE=$(find . -name 'mariadb-java-client-*.jar')

# mv $JAR_FILE $TARGET_DIR

# chown $(stat -c '%U:%G' $TARGET_DIR) $TARGET_DIR/mariadb-java-client-*.jar
# chmod $(stat -c '%a' $TARGET_DIR) $TARGET_DIR/mariadb-java-client-*.jar

# sed -i "s/type: .*/type: mariadb/" "$SYSTEM_YAML"
# sed -i "s/driver: .*/driver: org.mariadb.jdbc.Driver/" "$SYSTEM_YAML"
# sed -i "s/url: .*/url: jdbc:mariadb:\/\/127.0.0.1:3306\/artdb?characterEncoding=UTF-8\&elideSetAutoCommits=true\&useSSL=false\&useMysqlMetadata=true/" "$SYSTEM_YAML"
# sed -i "s/username: .*/username: artifactory/" "$SYSTEM_YAML"
# sed -i "s/password: .*/password: password/" "$SYSTEM_YAML"

# if [ ! -f "$MYSQL_CONF" ]; then
#     echo "" > $MYSQL_CONF
#     echo "# The MariaDB server" >> $MYSQL_CONF
#     echo "[mysqld]" >> $MYSQL_CONF
# fi
# echo "max_allowed_packet=134217728" >> $MYSQL_CONF
# echo "innodb_file_per_table=1" >> $MYSQL_CONF
# echo "innodb_buffer_pool_size=1536M" >> $MYSQL_CONF
# echo "tmp_table_size=512M" >> $MYSQL_CONF
# echo "max_heap_table_size=512M" >> $MYSQL_CONF
# echo "innodb_log_file_size=256M" >> $MYSQL_CONF
# echo "innodb_log_buffer_size=4M" >> $MYSQL_CONF

# sudo systemctl restart mariadb

# echo "Installation and configuration complete."