![OpenSUSE](https://img.shields.io/badge/OpenSUSE-0C322C?style=for-the-badge&logo=SUSE&logoColor=white)

# OpenSUSE

OpenSUSE es el sistema operativo que tengo instalado como sistema nativo en mi PC. Elegí este sistema por escapar del mundo ```Debian``` y probar cosas nuevas. El primer intento fue _Manjaro_, pero no podía usar el _Secure Boot_. Tras un petardazo del _insider preview_ de Windows 11 tuve que instalar dicho sistema desde 0, y con ello aproveché para formatear todos los discos y probar este sistema.

## Instalando software esencial

Considero que como desarrollador voy a necesitar una batería de software bastante completa que se puede resumir en este apartado. Principalmente, voy a necesitar herramientas de Git (GitKraken), IDEs como Visual Studio Code y algún que otro compilador.

Podemos saltarnos los pasos siguientes haciendo uso de [este script](install_files/install_essential_software.sh) de la siguiente manera, o bien, hacerlo por partes:

```bash
# Ejecución del script
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/OpenSUSE/install_files/install_essential_software.sh
sh install_essential_software.sh
rm -f install_essential_software.sh
```

### Instalando paquetes esenciales:

Los paquetes que he considerado esenciales en el entorno de desarrollo son los siguientes, aunque puede que alguno ya venga instalado:

```bash
zypper install -y git gcc gcc-c++ gdb valgrind make busybox-net-tools
zypper install -y opencv openmp-devel
```

Por otra parte, en el entorno multimedia, me he decantado por instalar estos paquetes:

```bash
zypper install -y vlc qbittorrent
```

### Instalación de Visual Studio Code

Este es uno de mis IDEs favoritos, por lo que no puede faltar en mi sistema Linux. Para poderlo instalar tendremos que añadir el repositorio y descargarlo:

```bash
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
zypper refresh
zypper install -y code
```

### Instalación de GitKraken

GitKraken es una GUI de Git bastante completa y sencilla de usar con la que estoy bastante acostumbrado a trabajar, por lo que no puede faltar en mi sistema Linux. Para instalar este paquete, nos lo descargaremos de internet:

```bash
wget https://release.gitkraken.com/linux/gitkraken-amd64.rpm
zypper install gitkraken-amd64.rpm
rm -f gitkraken-amd64.rpm
```

### Mis GNOME Extensions favoritas

Prefiero usar el escritorio de GNOME porque con KDE el uso de múltiples pantallas es bastante penoso. Espero que cuando Wayland esté a pleno funcionamiento la cosa cambie, pero creo que me quedaré con GNOME. Este entorno gráfico tiene un aire muy parecido a Mac y eso me gusta bastante. Así mismo, al GNOME base que incluye OpenSUSE creo que le hacen falta unos complementos, a mi parecer bastante útiles, como los siguientes:

- Un menú de aplicaciones completo, desplegable desde la barra de arriba. El que yo instalo es [ArcMenu](https://extensions.gnome.org/extension/3628/arcmenu/) y, además, se le puede cambiar el icono. Un puntazo.
- Un controlador del dock que verdaderamente brinde una experiencia a lo Mac. El que yo uso es [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/).
- Un controlador de la velocidad de nuestra conexión a Internet. Yo uso [NetSpeed](https://extensions.gnome.org/extension/104/netspeed/).
- Un indicador y controlador del espacio de trabajo. Me parece interesante [Workspace indicator](https://extensions.gnome.org/extension/3952/workspace-indicator/)

### Añadiendo el repositorio Packman para obtener los controladores propietarios de audio y vídeo que nos faltan

Tal vez hemos intentado reproducir un archivo MKV (vídeo de alta calidad) y no nos ha funcionado. Esto se debe a que faltan drivers de formatos propietarios. Se soluciona rápido:

```bash
sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
sudo zypper ref
sudo zypper dup --from packman --allow-vendor-change
```

Ahora se nos descargarán muchísimos paquetes y ya podremos reproducir vídeo con la traquilidad de que va a funcionar.

### Adiós BASH, hola ZSH

Esto es bastante irrelevante pero, como usé ZSH en Manjaro y me gustó tanto, ahora también la quiero en OpenSUSE. Esto no es nada más que instalar un intérprete de Shell distinto. Para instalarlo usaremos el siguiente conjunto de comandos:

```bash
sudo zypper install zsh
```

Ahora tocaría cambiar al nuevo Shell y configurarlo, para ello basta con hacer esto y leer y seguir los pasos:

```bash
zsh
```

Una vez configurado tendremos que cambiar el shell por defecto, y para ello usaremos este comando y seguiremos los pasos que nos pidan:

```bash
# Listado de shells:
cat /etc/shells

# Cambiar el shell por defecto:
chsh
```

Finalmente, reiniciamos el sistema y veremos los cambios. No son muy estéticos, la verdad. Ahora nos tocará instalar _Oh my Shell!_:

```bash
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

Finalmente, para escoger un tema (a mi me gusta _agnoster_) entraremos al archivo de configuración de ZSH mediante el comando ```sudo nano .zshrc

## Instalación de herramientas para desarrolladores

Aquí un listado de algunas herramientas para desarrolladores que he tenido que instalar en algún momento:

- [CompiladoresCPP](CompiladoresCPP.md)
- [OpenMPI](OpenMPI.md)

