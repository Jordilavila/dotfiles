#######################################
### INSTALACION DE DHCP ROCKY LINUX ###
#######################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

dnf update && dnf upgrade -y
dnf install -y dhcp-server
systemctl enable dhcpd
firewall-cmd --add-service=dhcp
firewall-cmd --runtime-to-permanent
echo "Se ha instalado el servidor DHCP y se han establecido nuevas reglas para el firewall."
echo "Edita el archivo /etc/dhcp/dhcpd.conf con la configuración apropiada."
