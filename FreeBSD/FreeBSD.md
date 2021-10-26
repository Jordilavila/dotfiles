![Free BSD](https://img.shields.io/badge/FreeBSD-EE0000?style=for-the-badge&logo=freebsd&logoColor=white)

# FreeBSD

FreeBSD es un sistema unix bastante usado para montar servidores o también usado por algún purista. Yo lo he tenido que usar por alguna asignatura de la carrera y bueno, lo personalicé un poco.

## Después de la instalación

Tras instalar FreeBSD tuve que instalar un servidor gráfico, en mi caso escogí KDE. Para instalar KDE recomiendo los siguientes pasos:

```bash
## Actualización del sistema
pkg update
pkg upgrade
```

```bash
## Instalación de KDE
mount -t procfs proc /proc
pkg install -y nano kde5 sddm xorg firefox chromium wget
sysrc dbus_enable="YES" && service dbus start
sysrc sddm_enable="YES" && service sddm start
```

La instalación de KDE se puede hacer corriendo como administrador el [archivo de instalación](https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_kde5.sh) que he adjuntado en el repositorio.

El archivo se puede descargar y ejecutar con los siguietnes comandos:

```bash
## Run as root
pkg install -y wget
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_kde5.sh
sh install_kde5.sh
```

Una vez que hemos instalado KDE5 y puesto en marcha el servicio, tendremos que cambiar de _Wayland_ a _X11_ en la pantalla de inicio de sesión.

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

## Una capa de personalización

Esto es opcional, sólo que me parecía un poco feo dejar FreeBSD así, con un KDE desnudo. Por lo tanto recopilé unas fotos de Internet y lo monté en un ZIP para que quien se las quiera poner se las ponga. Podéis desgar el famoso ZIP desde aquí, o usando wget como podemos ver a continuación:


