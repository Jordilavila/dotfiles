[![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)](RockyLinux.md)

# Rocky Linux (RedHat)

Rocky Linux es un sistema Linux, más concretamente un clon de RedHat Linux Enterprise. Es un sistema operativo bastante interesante de instalar en servidores, puesto que los servidores suelen funcionar con RedHat.

## Después de la instalación

Algunas cosas importantes que hacer tras instalar Rocky Linux.

### Herramientas esenciales y actualización del sistema

Antes de instalar cualquier cosa en un sistema, lo suyo es actualizarlo, por lo que escribiremos en la consola los siguientes comandos:

```bash
dnf update
dnf upgrade
```

Tras actualizar el sistema, es interesante instalar algunos paquetes como los _paquetes extra_:

```bash
# Instalamos los paquetes extra:
dnf install epel-release
```

### Si estamos en VirtualBox

Si estamos en VirtualBox necesitaremos instalar las GuestAdditions. Esto es sencillo de hacer. Para instalarlas, podemos escribir las líneas siguientes y seguir las instrucciones:

```bash
# Instalamos las herramientas necesarias:
dnf install gcc make perl kernel-devel kernel-headers bzip2 dkms
```

Tras instalar las herramientas anteriores, insertamos el CD de las GuestAdditions y ejecutamos el instalador.

## Puesta a punto de las redes

Para poner en funcionamiento las interfaces de red en Rocky Linux tendremos que movernos al directorio ```/etc/sysconfig/network-scripts/```. En este directorio tendremos como archivos todas las interfaces de red que tiene nuestra máquina.

En mi caso, estoy trabajando bajo VirtualBox, por lo tanto, las redes que me aparecen son ```ifcfg-enp0s3``` y ```ifcfg-enp0s6``` (NatNetwork y Host-Only, respectivamente).

Tendremos que verificar que ambas redes tengan el parámetro ```ONBOOT``` establecido en ```YES```. Finalmente, reiniciamos el servicio o el sistema, como siempre, recomiendo reinciar el servicio: 

```bash
systemctl restart NetworkManager.service
```

## Conjunto de servicios:

En este apartado tenemos los enlaces a las distintas opciones que podríamos configurar en nuestro servidor Rocky Linux:

- [Servicios de Acceso Remoto](RemoteServices.md)
- [Servicios de Directorios](DirectoryServices.md)
- [Servicios de Impresión](PrintServices.md)
- [Servicios de Red](NetworkingServices.md)
- [Servicios de Bases de Datos y Web](WebAndDatabaseServices.md)
- [Servicios de Autenticación](AuthenticationServices.md)

- [Backup](rocky_backup.md)
- [FTP Server](rocky_ftp.md)
- [Mensajería Instantánea (OpenFire)](rocky_mens_inst.md)
- [Nagios](rocky_nagios.md)
- [Proxy](rocky_proxy.md)
- [RAID 5](rocky_raid5.md)
