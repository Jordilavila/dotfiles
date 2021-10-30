###################################
### INSTALACION DE CUPS FOR PDF ###
###################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

pkg install cups print/gutenprint print/hplip cups-PDF

echo "[system=10]
add path 'unlpt*' mode 0660 group cups
add path 'ulpt*' mode 0660 group cups
add path 'lpt*' mode 0660 group cups" >> /etc/devfs.rules

sysrc cupsd_enable="YES"
sysrc devfs_system_ruleset="system"

service devfs restart
service cupsd restart

