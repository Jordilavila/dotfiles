[![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)](RockyLinux.md)

# Servicios de Red

## DHCP

## DNS

## GIT

## OwnCloud

Estamos acostumbrados a utilizar los servicios en la nube de Dropbox, OneDrive, Google, Amazon, etc. Pero, ¿y si nos creamos nuestra propia nube privada? Pues es posible, tan solo necesitamos _OwnCloud_.

_OwnCloud_ es una aplicación de software libre que permite el almacenamiento en línea y aplicaciones en línea. Lo podemos instalar un servidor que disponga de una versión reciente de PHP y con soporte de SQLite, MySQL/MariaDB o PostgreSQL, lo que cumple con los requisitos para instalarlo en nuestro servidor FreeBSD.

Los requisitos para llevar a cabo la instalación de _OwnCloud_ en nuestro caso, son los siguientes:

- MariaDB o MySQL
- Apache
- Un VirtualHost en Apache para _OwnCloud_
- PHP

### Creando la base de datos

Lo primero será crear la base de datos con MariaDB. Para ello nos loguearemos con ```mysql -u root -p``` usaremos los siguientes comandos:

```sql
CREATE USER 'owncloud_user'@localhost IDENTIFIED BY 'owncloud_user';
CREATE DATABASE owncloud_db;
GRANT ALL ON owncloud_db.* TO 'owncloud_user'@'localhost' IDENTIFIED BY 'owncloud_user';
FLUSH PRIVILEGES;
EXIT;
```

### Descargando OwnCloud

Para descargar _OwnCloud_ vamos a realizar lo siguiente:

```bash
wget https://download.owncloud.org/community/owncloud-complete-20210721.zip -O owncloud.zip
mkdir /var/www/minube.com
unzip owncloud.zip -d /var/www/minube.com/
chown apache:apache -R /var/www/minube.com/owncloud
chmod -R 775 /var/www/minube.com/owncloud
```

Ahora tendríamos que crear el archivo ```/etc/httpd/conf.d/owncloud.conf``` y añadirle el código que sigue:

```bash
Alias /owncloud "/var/www/minube.com/owncloud/"

<Directory /var/www/minube.com/owncloud/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www/minube.com/owncloud
 SetEnv HTTP_HOME /var/www/minube.com/owncloud

</Directory>
```

Ahora debemos reiniciar apache con ```systemctl restart httpd``` y podríamos entrar en la dirección web que tenemos configurada para instalar OwnCloud en nuestro servidor, pero no lo vamos a lograr porque la última versión de OwnCloud no es compatible con FreeBSD.
