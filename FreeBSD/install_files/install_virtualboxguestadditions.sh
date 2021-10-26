############################################################
### INSTALACION DE VIRTUALBOX GUEST ADDITIONS EN FREEBSD ###
############################################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

pkg install -y emulators/virtualbox-ose-additions
sysrc vboxguest_enable="YES"
sysrc vboxservice_enable="YES"