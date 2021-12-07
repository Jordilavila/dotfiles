![Free BSD](https://img.shields.io/badge/FreeBSD-B50000?style=for-the-badge&logo=freebsd&logoColor=white)

# Nagios

Nagios es un sistema de monitorización de redes que vigila los equipos y los servicios que se especifiquen, alertando cuando el comportamiento de los mismos no sea el deseado. Entre sus características principales figuran la monitorización de servicios de red, la monitorización de los recursos de sistemas hardware (carga de la cpu, uso de discos, etc.), independencia de sistemas operativos, etc.

Este software es bastante versátil para consultar prácticamente cualquier parámetro de interés de un sistema, y genera alertas que se pueden recibir por email y SMS. Otro dato interesante es que se consulta en una web en PHP que montamos en el servidor.

Para instalar Nagios, podremos hacerlo con un script que he preparado o paso por paso.

## Preparando las dependencias

### Usando el script

Para usar el script será tan sencillo como hacer uso de los siguientes comandos:

```bash
# Run as root
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_nagios.sh
sh install_nagios.sh
```

El script acaba con la descompresión de la carpeta de Nagios.

### Usando los comandos

Lo primero que haremos será una actualización del sistema y luego instalaremos las dependencias. Finalmente, descargaremos nagios y lo descomprimiremos. Exactamente igual que se haría con el script:

```bash
# Instalación de dependencias:
pkg install apache24 mod_php74 php74-gd
service apahce24 enable

# Descargamos el código de nagios:
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz -O nagios.tar.gz
tar -xzf nagios.tar.gz
```