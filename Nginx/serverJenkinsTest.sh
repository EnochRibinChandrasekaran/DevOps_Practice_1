#!/usr/bin/bash
 
# Update logging configuration
echo "Updating logging configuration..."
sudo sh -c "echo '*.info;mail.none;authpriv.none;cron.none /dev/ttyS0' >> /etc/rsyslog.conf"
sudo systemctl restart rsyslog
 
# Display user and directory information
echo "Logged in as $USER."
echo "In directory $PWD"
 
# Install Nginx
echo "Installing Nginx..."
sudo yum install nginx -y
 
# Copy custom Nginx configuration file
echo "Copying custom Nginx configuration file..."
sudo cp nginx.conf /etc/nginx/nginx.conf
 
 
 
# Restart Nginx to apply changes
echo "Restarting Nginx..."
sudo systemctl restart nginx