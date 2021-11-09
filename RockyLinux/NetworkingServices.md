[![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)](RockyLinux.md)

# Servicios de Red

## DHCP

_DHCP_ es un protocolo de configuración dinámica de Host. Se trata un protocolo de red cliente/servidor con el que se asigna dinámicamente una dirección IP y otros parámetros de configuración de red a cada dispositivo en una red para que puedan comunicarse con otras redes IP. El servidor guarda una tabla de IPs asociadas a las MAC de algunas máquinas para asignar la dirección a éstas de manera prácticamente instantánea cuando se vuelvan a conectar a la red.

### Instalación de DHCP

La instalación del servidor DHCP en Rocky Linux se puede realizar con un script que he preparado o con los comandos de instalación.

#### Opción 1: Instalación desde script

Para instalar DHCP con el script que he preparado tendremos que hacer lo siguiente:

```bash

```

#### Opción 2: Instalación desde comandos

Para instalar DHCP con los comandos de instalación realizaremos lo siguiente:

```bash
# Actualización del sistema
dnf update && dnf upgrade -y

# Instalación del servidor DHCP
dnf install -y dhcp-server

# Configurando las reglas para el firewall
firewall-cmd --add-service=dhcp
firewall-cmd --runtime-to-permanent

# Habilitando el servicio 
systemctl enable dhcpd
```

### Configuración del servidor DHCP

Para configurar el servidor DHCP entraremos al archivo ```/etc/dhcp/dhcpd.conf``` y lo dejaremos tal que así (en mi caso):

```bash
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp-server/dhcpd.conf.example
#   see dhcpd.conf(5) man page
#

option domain-name "rocky.jordi.es";

option domain-name-server rocky.jordi.es;

default-lease-time 600;

max-lease-time 7200;

authoritative;

subnet 192.168.137.0 netmask 255.255.255.0 {
        range dynamic-bootp 192.168.137.51 192.168.137.100;
        option broadcast-address 192.168.137.255;
        option routers 192.168.137.1:
}
```

Ahora tendríamos que reiniciar el servicio con el comando ```systemctl restart dhcpd``` y arrancar una segunda máquina a modo de cliente y verificar que se conecte con el servidor DHCP.

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
