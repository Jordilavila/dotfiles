[![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)](RockyLinux.md)

# _Backup_

Lo primero que vamos a hacer es crearnos los archivos de logs:

```bash
# Creando los logs:
mkdir /logs
touch /logs/backup.log
```

Ahora creamos el directorio donde guardaremos las copias de seguridad y el directorio al que queremos hacerle las backups:

```bash
# Directorio de copias:
mkdir /backups

# Directorio que guardaremos:
mkdir /tosave
```

Tras esto, escribimos el siguiente script en el _cron_ mediante el comando ```crontab -e```:

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
0 1 * * 6 /bin/sh /root/backup.sh -a >> /logs/backup.log
0 1 * * 0,1,2,3,4,5 /bin/sh /root/backup.sh -d >> /logs/backup.log
```

Con esta entrada del _cron_ estaremos estableciendo los días en los que se van a ejecutar los scripts de backup. Concretamente, este script está preparado para ejecutar los sábados un backup absoluto (-a). Por otra parte, el resto de días de la semana estaremos ejecutando un backup diferencial (-d).

Finalmente, para que se pueda ejecutar la copia de seguridad, necesitaremos el script de bash que nos realice la tarea. El script lo guardaremos en ```/root/backup.sh```:

```bash
#!/bin/bash
# This script is prepared to backup data in two ways: weekely or daily
# Add to crontab with -d to have a daily backup respect to the saturday.
# else the file will be uploaded to Mega
#
# Variables to fill
#
# backup file name of the absolute copy:
BACKUP_FILE_NAME_ABS="Abs"
# backup file name of the differential copy:
BACKUP_FILE_NAME_DIFF="Diff"
# Where to backup
dest="/backups"
# What to backup
backup_files="/tosave"
# Begin the script
#
. ~/.bash_profile
if [ $1 = "-d" ]
then
    echo "Copia diferencial"
    DATE=$( date -d "last sat" +%Y%m%d )
    TYPE=$BACKUP_FILE_NAME_DIFF
    archive_file="$DATE-$TYPE.tar.gz"
    tar czf $dest/$archive_file $backup_files
    echo "Fin de la copia de seguridad. Archivos:"
    ls -lh $dest
elif [ $1 = "-a" ]
then
    echo "Copia absoluta"
    DATE=$( date -d "now" +%Y%m%d )
    TYPE=$BACKUP_FILE_NAME_ABS
    archive_file="$DATE-$TYPE.tar.gz"
    tar czf $dest/$archive_file $backup_files
    echo "Fin de la copia de seguridad. Archivos:"
    ls -lh $dest
else
    echo "Opción inválida"
    echo "Las opciones válidas son:"
    echo "-d Copia diferencial"
    echo "-a Copia absoluta"
    echo ""
fi
```
