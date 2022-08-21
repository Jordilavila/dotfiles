![Raspberry Pi OS](https://img.shields.io/badge/Raspberry%20Pi%20OS-C51A4A?style=for-the-badge&logo=Raspberry-Pi)  
![Bash](https://img.shields.io/badge/Bash-%23121011.svg?style=flat-square&logo=gnu-bash&logoColor=white)

# Backup Service

La importancia de un servicio de copias de seguridad reside en mantener una copia fuera del servidor de los datos que queremos conservar en caso de que el servidor se corrompa o deje de funcionar.

Nos interesa saber qué ocurre con estas copias de seguridad y guardar la información en un LOG. Las copias de seguridad se almacenarán en un disco duro externo y los logs de la misma también. Aprovechando el servicio del disco duro en red que puedes encontrar [aquí](hddred.md) guardaremos las _backups_ y los _logs_ en dicho disco en red.

## Preparación: Directorios de logs y de backups

Lo primero que vamos a hacer será crearnos nuestros directorios de backups y el archivo de log. Esto se creará dentro de una carpeta llamada _rpibackups_ dentro del disco duro en red. Tal que así:

```bash
# Creando el árbol de carpetas:
mkdir /media/HDDRED/rpibackups
mkdir /media/HDDRED/rpibackups/backups

# Creando los logs:
touch /media/HDDRED/rpibackups/backupservice.log
```

## Crontab

En los sistemas Linux tenemos el Cron que no es más que un administrador de procesos en segundo plano o _daemons_ (demonios) que se encarga de ejecutar procesos en intervalos regulares de tiempo. Estos procesos y los momentos en los que se tienen que ejecutar se especifican en un fichero llamado _crontab_.

Por otra parte, _crontab_ sólo es un simple fichero de texto que guarda un conjunto de comandos a ejecutar en un tiempo especificado por el usuario. Se verificará la fecha y hora en la que se tiene que ejecutar dicho comando y los permisos de ejecución y, lo ejecutará en segundo plano.

Ahora que ya sabemos qué son Cron y Crontab, vamos a abrir el Crontab y escribir el siguiente script. Para abrirlo utilizaremos el comando ```crontab -e```:

```bash
# crontab -e
SHELL=/bin/bash
MAILTO=root
HOME=/root
# For details see man 4 crontabs
# Example of job definition:
# .---------------- minute (0 - 59)
# | .------------- hour (0 - 23)
# | | .---------- day of month (1 - 31)
# | | | .------- month (1 - 12) OR jan,feb,mar,apr ...
# | | | | .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# | | | | |
# * * * * * username command to be executed
0 1 * * 6 /bin/sh /root/backup.sh -a >> /media/HDDRED/rpibackups/backupservice.log
0 1 * * 0,1,2,3,4,5 /bin/sh /root/backup.sh -d >> /media/HDDRED/rpibackups/backupservice.log
```

Por ahora, le hemos dicho al Cron que queremos que ejecute ciertos comandos con cierto archivo de Shell que no existe, por lo tanto, nos toca crear dicho archivo.

## Script de Backups

Podemos encontrar el script justo [aquí](../files/backup.sh), que es tal que así:

```bash
#!/bin/bash

####################################
#
# Backup to NFS mount script.
#
####################################

# What to backup. 
backup_files="/home/pi/TelegramBots /var/www/html"

# Where to backup to.
dest="/media/HDDRED/rpibackups/backups"

# This script is prepared to backup data in two ways: weekely or daily
# Add to crontab with -d to have a daily backup respect to the saturday.
# 
# The weekely backup is an absolute backup, while the daily backup is a differential backup.
#
# Variables to fill:
#
# backup file name of the absolute copy:
BACKUP_FILE_NAME_ABS="Abs"
# backup file name of the differential copy:
BACKUP_FILE_NAME_DIFF="Diff"

# RSYNC variables
set -o errexit
set -o nounset
#set -o pipefail

readonly SOURCE_DIR=$backup_files
readonly BACKUP_DIR=$dest
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"

mkdir -p "${BACKUP_DIR}"
mkdir -p "${LATEST_LINK}"

# Begin the script
#
#. ~/.bash_profile
if [ $1 = "-d" ]
then
    echo "Differential Backup"
    rsync -aRv --delete \
        ${SOURCE_DIR} \
        --link-dest "${LATEST_LINK}" \
        --exclude-from="backup_exclude.lst" \
        "${BACKUP_PATH}"
    
    rm -rf "{$LATEST_LINK}"
    echo "Backup finished. Files:"
    ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
elif [ $1 = "-a" ]
then
    echo "Absolute Backup"
    DATE=$( date -d "now" +%Y%m%d )
    TYPE=$BACKUP_FILE_NAME_ABS
    archive_file="$DATE-$TYPE.tar.gz"
    tar czf $dest/$archive_file $backup_files
    echo "Backup finished. Files:"
    ls -lh $dest
else
    echo "Invalid option"
    echo "The options are the next:"
    echo "-d Differential backup"
    echo "-a Absolute backup"
    echo ""
fi
```

## Ubicando el script

Para ubicar nuestro script, creamos un fichero llamado `backup.sh`:

```bash
nano backup.sh
```

Cuando se nos abre el editor de texto, simplemente copiamos y pegamos el script anterior. Moldéalo a tus necesidades, evidentemente.

A parte de todo esto, es necesitamos una lista con los directorios que queremos excluir de la copia de seguridad. Para crear este archivo, lo haremos tal que así:

```bash
nano backup_exclude.lst
```

Un ejemplo de archivo de exclusión:

```
/var/www/html/moodle/
/var/www/html/phpmyadmin
/var/www/html/admin
/var/www/html/pihole
.cache
```

Una vez hecho, guardamos y probamos el script tal que así:

```bash
sudo sh backup.sh -d
sudo sh backup.sh -a
```

Finalmente, ya tenemos nuestro script funcionando. Y, como el crontab ya está rellenado, las copias de seguridad se harán automaticamente.


