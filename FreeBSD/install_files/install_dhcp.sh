####################################
### INSTALACION DE DHCP FREE BSD ###
####################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

pkg update -y && pkg upgrade -y
pkg install -y dhcpd
sysrc dhcpd_enable="YES"
sysrc dhcpd_ifaces="em1"
service dhcpd restart
echo "Se ha instalado el servidor DHCP."
echo "Edita el archivo /usr/local/etc/dhcpd.conf con la configuración apropiada."