
# Servidor FTP

El objetivo de instalar un servidor FTP en nuestro sistema es permitir la transferencia de archivos entre el cliente y el servidor. Este servicio trabaja con el puerto 21.

Vamos a instalar un servidor FTP en FreeBSD mediante ```vsftpd```. También vamos a ver dos configuraciones posibles:

    - Usuario libre (tendrá acceso a todo el disco)
    - Usuario enjaulado (sólo podrá acceder donde nosotros queramos)

Dato importante: Para conectarnos al servidor FTP usaremos el puerto 21.

## Instalación

Empezamos la instalación con el siguiente comando:

```bash
pkg install vsftpd-ssl
```

Tras esto, tendremos que acceder al archivo de configuración para realizar unos pequeños cambios. El archivo de configuración es ```/usr/local/etc/vsftpd.conf``` y los cambios son los siguientes:

```bash
write_enable=YES

ascii_upload_enable=YES
ascii_download_enable=YES

chroot_local_user=YES
chroot_list_enable=YES

chroot_list_file=/etc/vsftpd.chroot_list

ls_recurse_enable=YES

listen=YES

listen_ipv6=NO

##########

## Added by me:
# Directorio root 
user_sub_token=$USER
local_root=/usr/local/www/ftp/$USER
# Tiempo local
use_localtime=YES
# Apagar el filtro seccomp (descomentar si no podemos loggearnos)
seccomp_sandbox=NO
```

## Configuración del servicio

Ahora nos tocará añadir a nuestro usuario al archivo donde se configuran los usuarios que tienen el acceso permitido a todo el disco. Este archivo no se crea por defecto en la instalación, por lo que tendremos que crearlo nosotros tal que así: ```touch /etc/vsftpd.chroot_list```.

```bash
# Con este comando, aunque estemos con privilegios escalados, añadiremos al usuario con el que nos hemos logueado inicialmente.
echo $USER >> /etc/vsftpd.chroot_list
```

Ahora habilitamos el servicio y lo lanzamos:

```bash
service vsftpd enable
service vsftpd restart
```

Ahora ya podríamos conectarnos a nuestro usuario principal y acceder a todo el disco:

![FTP Libre](images/freebsd_ftp_libre.png)

## Usuario enjaulado

Para poder establecer como enjaulado a un usuario, lo primero que tendremos que hacer será crearlo, tal que así:

```bash
adduser
# He creado un usuario llamado pruebas y su contraseña también es pruebas, para que sea más visual y sencillo.
```

Tras crear el usuario, tendremos que añadir en el archivo de configuración de _vsftpd_ la instrucción para habilitarlo:

```bash
echo "# Habilitar usuario enjaulado" >> /usr/local/etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /usr/local/etc/vsftpd.conf

mkdir /usr/local/www/ftp
mkdir /usr/local/www/ftp/pruebas
chmod -R 777 /usr/local/www/ftp/pruebas
# Usuario logueado: mkdir /usr/local/www/ftp/$USER

service vsftpd restart
```

Y ahora ya podríamos hacer uso de este usuario.

Cabe destacar que con la configuración que he hecho en el archivo destinado para ese fin, cualquier usuario que tenga su directorio creado en la ruta del server FTP (```/usr/local/www/ftp/```) tendrá acceso a su carpeta, puesto que lo he creado dinámico.

![FTP Jaula](images/freebsd_ftp_jaula.png)
