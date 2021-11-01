#######################################
### INSTALACION DE SAMBA EN FREEBSD ###
#######################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "kern.maxfiles=25600" >> /etc/sysctl.conf
echo "kern.maxfilesperproc=16384" >> /etc/sysctl.conf
echo "net.inet.tcp.sendspace=65536" >> /etc/sysctl.conf
echo "net.inet.tcp.recvspace=65536" >> /etc/sysctl.conf

echo 'aio_load="YES"' >> /boot/loader.conf

pkg install -y samba413-4.13.8_1

touch /usr/local/etc/smb4.conf

echo "[global]
    workgroup = WORKGROUP
    realm = workgroup.local
    netbios name = BSDSMB

[usuario data]
    path = /home/usuario
    public = no
    writable = yes
    printable = no
    guest ok = no
    valid users = usuario" >> /usr/local/etc/smb4.conf

sysrc samba_server_enable="YES"

echo "Please, reboot your system!"
