![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)

# Rocky Linux (RedHat)

Rocky Linux es un sistema Linux, más concretamente un clon de RedHat Linux Enterprise. Es un sistema operativo bastante interesante de instalar en servidores, puesto que los servidores suelen funcionar con RedHat.

## Después de la instalación

Algunas cosas importantes que hacer tras instalar Rocky Linux.

### Herramientas esenciales y actualización del sistema

Antes de instalar cualquier cosa en un sistema, lo suyo es actualizarlo, por lo que escribiremos en la consola los siguientes comandos:

```bash
dnf update
dnf upgrade
```

Tras actualizar el sistema, es interesante instalar algunos paquetes como los _paquetes extra_:

```bash
# Instalamos los paquetes extra:
dnf install epel-release
```

### Si estamos en VirtualBox

Si estamos en VirtualBox necesitaremos instalar las GuestAdditions. Esto es sencillo de hacer. Para instalarlas, podemos escribir las líneas siguientes y seguir las instrucciones:

```bash
# Instalamos las herramientas necesarias:
dnf install gcc make perl kernel-devel kernel-headers bzip2 dkms
```

Tras instalar las herramientas anteriores, insertamos el CD de las GuestAdditions y ejecutamos el instalador.

## Puesta a punto de las redes

Para poner en funcionamiento las interfaces de red en Rocky Linux tendremos que movernos al directorio ```/etc/sysconfig/network-scripts/```. En este directorio tendremos como archivos todas las interfaces de red que tiene nuestra máquina.

En mi caso, estoy trabajando bajo VirtualBox, por lo tanto, las redes que me aparecen son ```ifcfg-enp0s3``` y ```ifcfg-enp0s6``` (NatNetwork y Host-Only, respectivamente).

Tendremos que verificar que ambas redes tengan el parámetro ```ONBOOT``` establecido en ```YES```. Finalmente, reiniciamos el servicio o el sistema, como siempre, recomiendo reinciar el servicio: 

```bash
systemctl restart NetworkManager.service
```

## Servicios remotos

Lo más normal es que usemos nuestro servidor de manera remota, por lo que usaremos algunos servicios remotos como ```SSH```, ```SFTP``` y ```SCP```.

Para instalar estos servicios tendremos que instalar ```SSH```, aunque ya nos lo encontramos instalado en nuestro sistema.

### Configuración de SSH

Es necesario que por seguridad configuremos algunos aspectos de SSH para que se prohiban los accesos al usuario root y las contraseñas vacías. Para ello, tendremos que abrir el archivo ```/etc/ssh/sshd_config``` y descomentar las líneas siguientes:

```bash 
PermitRootLogin no
PermitEmptyPasswords no
```

Y, para terminar, se reinicia el servicio: 

```bash
systemctl restart sshd
```

### Activando el log de SSH

Para activar el log de SSH tendremos que acceder al archivo ```/etc/ssh/sshd_config``` y modificar las líneas siguientes para que queden tal que así:

```bash
#Logging
SyslogFacility DAEMON
LogLevel DEBUG
```

Ahora sería interesante reiniciar el sistema o el servicio. Aunque siempre es más interesante reinciar el servicio:

```bash 
systemctl restart sshd
```

### Generando una contraseña en un cliente para acceder al servidor

Para general las claves públicas y privadas debemos hacer lo siguiente:

```bash 
# Escalar superusuario:
su -

# Generar claves pública y privada en el directorio /home/root/.ssd
ssh-keygen -t rsa

# Acceder al directorio donde están las claves:
cd /root/.ssh

# Enviar al ordenador destino las claves para que se conecte sin pedirle la contraseña.
ssh-copy-id -i id_rsa.pub SERVER_USERNAME@SERVER_IP
```

### Funcionamiento de SFTP

Este servicio viene con SSH, por lo que no hay que instalar nada. Sólo tenemos que saber como usarlo.

Para conectarnos por Secure File Transfer Protocol usaremos el siguiente comando:

```bash
sftp REMOTE_USER@REMOTE_IP
```

### Funcionamiento de SCP

Este servicio también viene con SSH, por lo tanto, no tendremos que instalar nada.

Para conectarnos por SCP usaremos el siguiente comando:

```bash
scp <-P <puerto>> <ruta de archivo local> REMOTE_USER@REMOTE_IP:<ruta destino>
```

## Servidor de impresión PDF con CUPS

Vamos a configurar un servidor de impresión usando CUPS para que nos imprima un archivo en formato PDF. Para ello vamos a tener que instalar un conjunto de paquetes y configurar y activar servicios. Todo esto vamos a poder hacerlo ejecutando un [script](install_files/install_cups.sh) que he escrito.

### Instalación de CUPS

Para instalar y habilitar CUPS podemos ejecutar el script o escribirlo a mano. Si queremos ejecutar el script debemos hacer lo siguiente:

```bash
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/RockyLinux/install_files/install_cups.sh
sh install_cups.sh
```

Por otra parte, si lo preferimos hacerlo a mano:

```bash
dnf install -y cups hplip gutenprint-cups cups-pdf
systemctl enable cups
systemctl start cups
```

Instalación de CUPS-PDF

```bash
wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/c/cups-pdf-2.6.1-7.el7.x86_64.rpm
dnf install -y cups-pdf-2.6.1-7.el7.x86-64.rpm
rm -f cups-pdf-2.6.1-7.el7.x86-64.rpm
```

Finalmente, comprobamos que el servicio está corriendo en nuestra máquina:

```bash
systemctl status cups
```

### Configuración de CUPS

CUPS se encuentra configurado por defecto para uso local, por lo tanto, vamos a configurarlo para que pueda funcionar en la red LAN. Para configurar CUPS tendremos que acceder al archivo de configuración que encontramos en ```/etc/cups/cupsd.conf```.

Lo primero que vamos a hacer será cambiar la línea siguiente:

```bash
### Línea original
Listen localhost:631

### Lína que necesitamos
Port 631
```

Ahora tendremos que compartir las impresoras en la red local:

```bash
### Bloque original:
# Show shared printers on the local network.
Browsing On
BrowseLocalProtocols dnssd

# Default authentication type, when authentication is required...
DefaultAuthType Basic

### Bloque a establecer:
# Show shared printers on the local network.
Browsing On
BrowseOrder allow,deny
BrowseLocalProtocols dnssd
#BrowseAllow @LOCAL
BrowseAllow 192.168.137.* # change to local LAN settings
BrowseAddress 192.168.137.* # change to local LAN settings

# Default authentication type, when authentication is required...
DefaultAuthType Basic
```

Finalmente, configuramos el servicio para que se pueda acceder a él en toda la red local:

```bash
### Bloque original:
# Restrict access to the server...
<Location />
  Order allow,deny
</Location>

# Restrict access to the admin pages...
<Location /admin>
  Order allow,deny
</Location>

# Restrict access to configuration files...
<Location /admin/conf>
  AuthType Default
  Require user @SYSTEM
  Order allow,deny
</Location>

### Bloque a escribir:
# Allow access to the server from any machine on the LAN
<Location />
  Order allow,deny
  Allow 192.168.137.* # change to local LAN settings
</Location>

# Allow access to the admin pages from any machine on the LAN
<Location /admin>
  #Encryption Required
  Order allow,deny
  Allow 192.168.137.* # change to local LAN settings
</Location>

# Allow access to configuration files from any machine on the LAN
<Location /admin/conf>
  AuthType Basic
  Require user @SYSTEM
  Order allow,deny
  Allow 192.168.137.* # change to local LAN settings
</Location>
```

Si tenemos clientes Windows en la red, será interesante modificiar los archivos ```/usr/share/cups/mime/mime.types``` y ```/usr/share/cups/mime/mime.convs``` para añadir la siguiente línea:

```bash
application/octet-stream
```

### Activando el log de CUPS

En el caso de querer activar el log de CUPS tendremos que acceder al archivo ```usr/local/etc/cups/cupsd.conf``` y cambiar la línea siguiente:

```bash
### Línea original:
LogLevel warn

### Línea a establecer:
LogLevel debug
```

### Permitiendo la conexión a través del Firewall

Para permitir las conexiones a la impresora a través del Firewall tendremos que introducir los siguietnes comandos:

```bash
firewall-cmd --permanent --add-port=631/tcp
systemctl reload firewalld
```

También tendremos que activar este servicio:

```bash
systemctl enable cups-browsed
systemctl start cups-browsed
```

## Servidor MySQL - MariaDB

Vamos a instalar y configurar MariaDB en nuestra máquina Rocky Linux. MariaDB es un servidor de bases de datos relacionales.

### Instalación 

Para llevar a cabo la instalación de MariaDB tenemos que escalar privilegios en la consola y escribir el comando de instalación:

```bash
dnf -y install mariadb-server mariadb
```

Tras esto, debemos levantar el servicio con ```systemctl start mariadb``` y habilitarlo con ```systemctl enable mariadb```.

Ahora tocaría darle las instrucciones para que se instale:

```bash
# Instalación segura
mysql_secure_installation

# Acceder al servidor
mysql -u root -p
```

Ahora podríamos crear una base de datos SQL:

```sql

```

## Servidor Apache y PhpMyAdmin

### Instalación de Apache

```bash
dnf install httpd -y
```

```bash
systemctl start httpd
systemctl enable httpd
```

```bash
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
```

### Instalación de PHPMyAdmin

```bash
dnf module reset php
dnf module eable php:7.4
dnf install php php-common php-opcache php-cli php-gd php-curl php-mysqlnd php-xml -y
```

Ahora descargamos y descomprimimos phpMyAdmin:

```bash
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip
unzip phpMyAdmin-*-all-languages.zip

# Si unzip no está instalado lo instalamos así:
dnf install unzip -y
```

```bash
mv phpMyAdmin-*-all-languages /usr/share/phpmyadmin
```

## TrueNAS + iSCSI

TrueNAS es un sistema operativo basado en FreeBSD dedicado a montar un servidor NAS 