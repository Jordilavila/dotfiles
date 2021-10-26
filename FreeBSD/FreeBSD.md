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
pkg install -y nano kde5 sddm xorg
sysrc dbus_enable="YES" && service dbus start
sysrc sddm_enable="YES" && service sddm start
```

La instalación de KDE se puede hacer corriendo como administrador el [archivo de instalación](install_files/install_kde5.sh) que he adjuntado en el repositorio.

Una vez que hemos instalado KDE5 y puesto en marcha el servicio, tendremos que cambiar de _Wayland_ a _X11_ en la pantalla de inicio de sesión.

### Si estamos en VirtualBox

Si estamos en VirtualBox vamos a querer instalar las GuestAdditions. Esto se hace de manera sencilla pues tenemos este script o podemos escribir las líneas siguientes:

```bash
pkg install -y emulators/virtualbox-ose-additions
sysrc vboxguest_enable="YES"
sysrc vboxservice_enable="YES"
```