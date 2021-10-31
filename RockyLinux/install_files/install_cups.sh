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

dnf install -y cups
systemctl enable cups
systemctl start cups

