![Free BSD](https://img.shields.io/badge/FreeBSD-B50000?style=for-the-badge&logo=freebsd&logoColor=white)

# FreeBSD

FreeBSD es un sistema unix bastante usado para montar servidores o también usado por algún purista. Yo lo he tenido que usar por alguna asignatura de la carrera y bueno, lo personalicé un poco.

## Después de la instalación

Algunas cosas importantes que hacer tras instalar FreeBSD.

### Actualización del sistema

Tras instalar un sistema operativo, lo primero que hay que hacer es actualizar el sistema operativo. Para actualizar el sistema usaremos los siguientes comandos:

```bash
# Run as root
pkg update && pkg upgrade -y
```

### Herramientas esenciales

Creo necesario instalar alguna paquetería de uso esencial como podría ser algún editor de texto de terminal como ```nano``` o la herramienta ```wget```. A continuación la manera de descargar estos paquetes necesarios sin los que el resto del tutorial no va a funcionar:

```bash
pkg install -y nano wget sudo
```

### Instalación de KDE

Tras instalar FreeBSD tuve que instalar un servidor gráfico, en mi caso escogí KDE. Para instalar KDE recomiendo los siguientes pasos:

```bash
## Instalación de KDE
mount -t procfs proc /proc
pkg install -y kde5 sddm xorg firefox chromium
sysrc dbus_enable="YES" && service dbus start
sysrc sddm_enable="YES" && service sddm start
```

La instalación de KDE se puede hacer corriendo como administrador el [archivo de instalación](https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_kde5.sh) que he adjuntado en el repositorio.

El archivo se puede descargar y ejecutar con los siguientes comandos:

```bash
## Run as root
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_kde5.sh
sh install_kde5.sh
```

:warning: **Importante:** una vez que hemos instalado KDE5 y puesto en marcha el servicio, tendremos que cambiar de _Wayland_ a _X11_ en la pantalla de inicio de sesión.

### Si estamos en VirtualBox

Si estamos en VirtualBox vamos a querer instalar las GuestAdditions. Esto se hace de manera sencilla pues tenemos [este script](https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_virtualboxguestadditions.sh) o podemos escribir las líneas siguientes:

```bash
pkg install -y emulators/virtualbox-ose-additions
sysrc vboxguest_enable="YES"
sysrc vboxservice_enable="YES"
```

El archivo se podría descargar y ejecutar con los siguientes comandos:

```bash
## Run as root
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_virtualboxguestadditions.sh
sh install_virtualboxguestadditions.sh
```

Esto podría lanzar un mensaje de aviso donde dice que para que las guestadditions funcionen bien, tendríamos que añadir a los usuarios que usen X11 en el grupo wheel. Para ello ejecutaremos la siguiente orden:

```bash
pw groupmod wheel -m YOUR_USERNAME
```

Ahora nos tocaría hacer un reboot del sistema.

### Una capa de personalización

Esto es opcional, sólo que me parecía un poco feo dejar FreeBSD así, con un KDE desnudo. Por lo tanto recopilé unas fotos de Internet y lo monté en un ZIP para que quien se las quiera poner se las ponga. Podéis desgar el famoso ZIP desde [aquí](https://github.com/Jordilavila/dotfiles/raw/main/FreeBSD/theme/FreeBSD_Theme.zip), o usando wget como podemos ver a continuación:

```bash
wget https://github.com/Jordilavila/dotfiles/raw/main/FreeBSD/theme/FreeBSD_Theme.zip
unzip FreeBSD_Theme.zip
```

Tras esto, nos quedaría escoger el tema _brisa oscuro_ y cambiar el fondo de escritorio al que nos encontramos en el zip (para tema oscuro, el fondo oscuro). Y, finalmente, cambiamos el icono de la barra de tareas por el de FreeBSD; esto se puede hacer haciendo click derecho sobre el icono actual y seleccionando _configurar el lanzador de aplicaciones_. 

Finalmente, nos queda algo así:

![FreeBSD Desktop](images/freebsd_desktop.png)

## Puesta a punto de las redes

Para poner en funcionamiento las interfaces de red en FreeBSD tendremos que acceder al archivo de configuración ```/etc/rc.conf``` para modificarlo.

Una vez accedemos a él, nos vamos a encontrar algo parecido a lo que vemos a continuación. Cabe destacar que yo estoy corriendo el sistema en Virtualbox con dos interfaces de red y se me pide que establezca la interfaz _host-only_ como estática:

```bash
hostname="freebsd_server"
keymap="es.kbd"
ifconfig_em0="DHCP"
sshd_enable="YES"
# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
dumpdev="AUTO"
zfs_enable="YES"
dbus_enable="YES"
sddm_enable="YES"
vboxguest_enable="YES"
vboxservice_enable="YES"
```

Una vez visto el archivo, procedemos a configurar la segunda interfaz de red como DHCP, para que asigne IP automaticamente. Esto será tan sencillo como añadir la línea ```ifconfig_em1="DHCP"``` al final del archivo, mismo. Esto puede servir, pero como ya he dicho, yo necesito que esta IP sea estática. Además de esto, he modificado un poco el archivo para que sea más claro:

```bash
# FreeBSD 
hostname="freebsd_server"
keymap="es.kbd"

# Networks:
ifconfig_em0="DHCP"
ifconfig_em1="inet 192.168.56.221 netmask 255.255.255.0"

# SSH: 
sshd_enable="YES"

# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
dumpdev="AUTO"
zfs_enable="YES"

# KDE5:
dbus_enable="YES"
sddm_enable="YES"

# VirtualBox:
vboxguest_enable="YES"
vboxservice_enable="YES"
```

Finalmente, reiniciamos.

## Conjunto de servicios:

En este apartado tenemos los enlaces a las distintas opciones que podríamos configurar en nuestro servidor Rocky Linux:

- [Servicios de Acceso Remoto](RemoteServices.md)
- [Servicios de Directorios](DirectoryServices.md)
- [Servicios de Impresión](PrintServices.md)
- [Servicios de Red](NetworkingServices.md)
- [Servicios de Bases de Datos y Web](WebAndDatabaseServices.md)
- [Servicios de Autenticación](AuthenticationServices.md)

- [Backup](fbsd_backup.md)
- [FTP Server](fbsd_ftp.md)
- [Mensarjería instantánea](fbsd_mens_inst.md)
- [Nagios](fbsd_nagios.md)
- [Proxy](fbsd_proxy.md)
- [RAID 5](fbsd_raid5.md)
