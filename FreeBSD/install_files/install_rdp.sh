#####################################
### INSTALACION DE RDP EN FREEBSD ###
#####################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

pkg install -y xrdp
sysrc xrdp_enable="YES"
sysrc xrdp_sesman_enable="YES"
service xrdp restart
