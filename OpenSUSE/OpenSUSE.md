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
zypper install -y git gcc gdb valgrind make
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
zypper install -y gitkraken-amd64.rpm
rm -f gitkraken-amd64.rpm
```
