# Montando un disco duro en red

He montado este servicio porque tenía un disco duro de 1Tb sin uso y quería usarlo para poder guardar contenido multimedia fuera del ordenador y poder acceder sin tener que pinchar dicho disco duro en ningún dispositivo, sino que accediendo desde la red pudiese ver el contenido.

Para ello lo primero será formatear el disco duro en NTFS, EXFAT o EXT4, a placer del lector. Yo lo he hecho en NTFS.

## Requisitos iniciales

### Actualización de la RaspberryPi

Lo primero que haremos será actualizar el sistema operativo:

```bash
sudo apt update && sudo apt upgrade -y
```

Tras actualizar el sistema operativo, actualizaremos el firmware de la Raspberry Pi:

```bash
sudo rpi-update
```

Si tras dicha actualización nos salta un mensaje que dice ```*** A reboot is needed to activate the new firmware```, reiniciamos:

```bash
sudo reboot
```

### Particionado y rutas

Suponiendo que hemos conectado el disco duro, ejecutamos el comando ```sudo blkid``` para ver la información de las particiones y nos anotamos el UUID de la partición del disco duro que vamos a usar en la red. En mi caso es SDA1.

En función del tipo de partición necesitaremos un software u otro:

```bash
### NTFS
sudo apt install ntfs-3g -y

### ExFAT
sudo apt install exfat-utils -y
```

Tras las instalaciones y anotaciones pertinentes, podemos comprobar las particiones mediante el comando ```sudo fdisk -l```.

Un paso importante va a ser el siguiente. Tenemos que crear la carpeta donde montaremos el disco duro y procederemos a montarlo:

```bash
sudo mkdir /media/HDDRED
sudo mount /dev/sda1 /media/HDDRED
```

Tras el montaje nos movemos al directorio en cuestión con un comando ```cd /media/HDDRED``` y listamos el disco duro, que si lo acabamos de formatear, evidentemente, no habrá nada:

```bash
ls -lrth
```

(Puede que imprima algunos directorios de configuración que crea Windows por defecto)

Ahora nos toca darle los permisos adecuados:

```bash
sudo chmod 755 /media/HDDRED
```

### Automontaje

El automontaje de un disco duro es un paso interesante. Mientras que Windows lo hace él solo, Linux necesita que le digas que quieres montar ese disco. Vamos a ello:

```bash
sudo nano /etc/fstab
```

¿Recuerdas que habías copiado el UUID del disco duro en los pasos anteriores? Pues añade esta línea al final del archivo:

```bash
UUID=EL_UUID_DE_TU_HDD /media/HDDRED ntfs defaults 0 0
```

Eso sí, si tu formato de disco es distinto a NTFS, tendrás que cambiarlo por el que sea: ExFAT (exfat), EXT4 (ext4), etc.

Tras esto, comprobamos que el fichero está bien con el comando ```sudo mount -a```. En caso de no dar ningún error, es que todo está correcto y puedes reiniciar.

Este disco duro se montará automáticamente siempre que permanezca inalterado. Es decir, siempre que no lo formateemos o que borremos particiones o cualquier cosa relacionada.

## Instalación y configuración de SAMBA

Lo primero que haremos será instalar SAMBA:

```bash
sudo apt install samba samba-common -y
```

Tras la instalación de SAMBA tendremos que añadir la configuración pertinente para el disco duro. Para ello abrimos el archivo ```/etc/samba/smb.conf``` y añadimos lo siguiente al final del mismo:

```bash
[hddred]
    comment = Disco duro multimedia de la Raspberry Pi
    path = /media/HDDRED
    browseable = Yes
    writeable = Yes
    only guest = no
    create mask = 0755
    directory mask = 0755
    public = Yes
```

Tras configurar el directorio a compartir, tendremos que cambiar la contraseña de SAMBA: ```sudo smbpasswd -a pi```

Tras final la configuración de SAMBA en la RPi, reiniciamos el servicio:

```bash
sudo service smbd restart
```

