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


