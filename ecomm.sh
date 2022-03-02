#! /bin/bash
sudo yum install -y httpd
sudo yum install -y git
sudo systemctl start httpd
sudo systemctl enable httpd
sudo git clone https://github.com/ravi2krishna/ecomm.git /var/www/html
