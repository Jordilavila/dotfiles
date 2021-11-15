[![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)](RockyLinux.md)

# Servicios de directorios

## NFS

Network File System es un protocolo de nivel de aplicación, según el Model OSI. Es utilizado para sistemas de archivos distribuido en un entorno de red de computadoras de área local. Este protocolo está incluido por defecto en los sistemas Unix y las distribuciones Linux. 

### Instalación y configuración de NFS

Lo primero que tendremos que hacer será actualizar el sistema e instalar el siguiente paquete:

```bash
dnf update -y
dnf upgrade -y
dnf install nfs-utils
```

Para configurar NFS tendremos, primeramente, que escribir los siguientes comandos en la consola:

```bash
mkdir /usr/NFS
chmod -R 777 /usr/NFS
```

Ahora tendremos que abrir el archivo ```/etc/exports``` y añadir las líneas siguientes:

```bash
/usr/NFS *(rw,sync,no_root_squash)
```

Ahora podemos reiniciar el servicio:

```bash
systemctl restart nfs-server
``` 

### Permitiendo el paso a través del firewall

Para que nos podamos conectar a nuestro NFS tendremos que darle paso a través del firewall con los siguientes comandos:

```bash
firewall-cmd --add-service=nfs
firewall-cmd --runtime-to-permanent
```

### Conectando desde el cliente:

Para conectarnos desde el cliente también tendremos que instalar el paquete de ```nfs-utils``` y ejecutar el siguiente comando:

```bash
mount -t nfs 192.168.137.222:/usr/NFS /mnt/NFSServer
```

Esto nos montará el directorio NFS en la ruta especificada.

## SAMBA

SAMBA es un servicio de compartición de datos entre Linux y Windows. Nos permite compartir datos y dispositivos en la red con este tipo de máquinas. 

### Instalando y configurando SAMBA

Para instalar SAMBA usaremos el siguiente comando:

```bash
dnf -y install samba samba-client samba-common
```

Ahora tendremos que registrar al usuario con el siguiente comando:

```bash
smbpasswd -a usuario
```

Finalmente, habilitamos y reiniciamos el servicio:

```bash
systemctl enable smb
systemctl restart smb
```

## TrueNAS + iSCSI

TrueNAS es un sistema operativo basado en FreeBSD dedicado a montar un servidor NAS 