###################################
### INSTALACION DE PHP EN ROCKY ###
###################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Install PHP 7.4
dnf module reset php
dnf module enable php:7.4
dnf install -y php php-common php-opcache php-cli php-gd php-curl php-mysqlnd php-xml php-zip php-intl php-json php-ldap php-mbstring

# Install PhpMyAdmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip
unzip phpMyAdmin-*-all-languages.zip
mv phpMyAdmin-*-all-languages /usr/share/phpmyadmin

mv /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php
mkdir /usr/share/phpmyadmin/tmp
chown -R apache:apache /usr/share/phpmyadmin
chmod 777 /usr/share/phpmyadmin/tmp