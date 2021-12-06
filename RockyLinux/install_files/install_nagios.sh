#########################################
### INSTALACION DE NAGIOS ROCKY LINUX ###
#########################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Instalación de dependencias:
dnf install -y php perl @httpd wget unzip glibc automake glibc-common gettext autoconf php php-cli gcc gd gd-devel net-snmp openssl-devel unzip net-snmp postfix net-snmp-utils
dnf -y groupinstall "Development Tools"
systemctl enable --now httpd php-fpm
systemctl start httpd
systemctl start php-fpm

# Descargamos el código de nagios:
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz -O nagios.tar.gz
tar -xzf nagios.tar.gz

echo "Entra en el directorio donde se ha descomprimido nagios y usa el comando ./configure para ver la configuración."
