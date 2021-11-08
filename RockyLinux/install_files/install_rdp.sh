###################################
### INSTALACION DE RDP EN ROCKY ###
###################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

dnf install -y xrdp
systemctl enable xrdp
systemctl start xrdp
firewall-cmd --add-port=3389/tcp
firewall-cmd --runtime-to-permanent
systemctl restart xrdp
