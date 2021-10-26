######################################
### INSTALACION DE KDE5 EN FREEBSD ###
######################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mount -t procfs proc /proc
pkg install -y nano kde5 sddm xorg
sysrc dbus_enable="YES" && service dbus start
sysrc sddm_enable="YES" && service sddm start