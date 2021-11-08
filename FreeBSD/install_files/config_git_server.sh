##################################
### CONFIGURACIÓN SERVIDOR GIT ###
##################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Creamos los directorios:
mkdir -p /home/git/.ssh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub > /home/git/.ssh/suthorized_keys
chown -R git:git /home/git/.ssh
chmod 0700 /home/git/.ssh
chmod 0600 /home/git/.shh/authorized_keys

# Habilitadno el servidor
sysrc git_daemon_enable="YES"
service git_daemon start



