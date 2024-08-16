#!/bin/bash
print_blue() {
    echo -e "\e[34m$1\e[0m"
}

print_blue " Update package lists"
sudo apt-get update

print_blue " Install Apache2"
sudo apt-get install apache2 -y

print_blue " Install PHP and Apache2 PHP module"
sudo apt-get install php libapache2-mod-php -y

print_blue " Install MariaDB server"
sudo apt-get install mariadb-server -y

print_blue " Secure MariaDB installation (non-interactive)"
sudo mysql_secure_installation <<EOF

n
y
y
y
y
EOF

print_blue " Install PHP MySQL module"
sudo apt-get install php-mysql -y

print_blue " Restart Apache2 service"
sudo service apache2 restart

print_blue " Install OpenSSH server"
sudo apt-get install openssh-server -y

print_blue " Start and enable SSH service"
sudo systemctl start ssh
sudo systemctl enable ssh

print_blue " Modify SSH configuration"
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config

print_blue " Restart SSH service"
sudo systemctl restart ssh

print_blue " Clone the GitHub repository"
sudo git clone https://github.com/PAN-DA-BOI/site-of-champs.git /var/www/html

print_blue "Setup completed successfully."
