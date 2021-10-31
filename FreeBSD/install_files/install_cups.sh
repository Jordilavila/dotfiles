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

pkg install cups hplip gutenprint-cups cups-pdf

wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/c/cups-pdf-2.6.1-7.el7.x86_64.rpm
dnf install -y cups-pdf-2.6.1-7.el7.x86-64.rpm
rm -f cups-pdf-2.6.1-7.el7.x86-64.rpm

echo "[system=10]
add path 'unlpt*' mode 0660 group cups
add path 'ulpt*' mode 0660 group cups
add path 'lpt*' mode 0660 group cups" >> /etc/defaults/devfs.rules

sysrc cupsd_enable="YES"
sysrc devfs_system_ruleset="system"

service devfs restart
service cupsd restart

