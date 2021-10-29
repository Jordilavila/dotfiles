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