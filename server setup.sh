
echo " Update package lists"
sudo apt-get update

echo " Install Apache2"
sudo apt-get install apache2 -y

echo " Install PHP and Apache2 PHP module"
sudo apt-get install php libapache2-mod-php -y

echo " Install MariaDB server"
sudo apt-get install mariadb-server -y

echo " Secure MariaDB installation (non-interactive)"
sudo mysql_secure_installation <<EOF

n
y
y
y
y
EOF

echo " Install PHP MySQL module"
sudo apt-get install php-mysql -y

echo " Restart Apache2 service"
sudo service apache2 restart

echo " Install OpenSSH server"
sudo apt-get install openssh-server -y

echo " Start and enable SSH service"
sudo systemctl start ssh
sudo systemctl enable ssh

echo " Modify SSH configuration"
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config

echo " Restart SSH service"
sudo systemctl restart ssh

echo " Clone the GitHub repository"
sudo git clone https://github.com/PAN-DA-BOI/site-of-champs.git /var/www/html

echo "Setup completed successfully."
