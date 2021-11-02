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

### Habilitando los logs en MariaDB

Para habilitar los logs tendremos que estar en la consola de MariaDB y escribir la siguiente batería de comandos:

```sql
-- Indicamos que la salida de los logs será en un archivo:
SET GLOBAL log_output = 'FILE';

-- Especificamos la ruta del archivo donde se guardarán los logs:
SET GLOBAL general_log_file='/var/log/mariadb/mariadb.log';

-- Habilitamos los logs
SET GLOBAL general_log = 'ON';
```

El nivel de _verbosity_ de los logs está establecido en 1 por defecto, pero tenemos 3 niveles: 1, 2 y 3. Para cambiar de nivel será tan sencillo como escribir el siguiente comando con el nivel necesitado, yo lo he dejado por defecto:

```sql
-- Verbosity level
SET GLOBAL log_warnings = 1;
```

### Creando una base de datos y su única tabla de pruebas:

Ahora podríamos crear una base de datos SQL:

```sql
CREATE DATABASE rockydb;

USE rockydb;

CREATE TABLE rockytable (
  opsys varchar(100),
  used_in_practice_1 varchar(20),
  used_in_practice_2 varchar(20),
  used_in_practice_3 varchar(20),
  primary key (opsys)
);

INSERT INTO rockytable values ('Rocky Linux', 'yes', 'yes', 'yes');
INSERT INTO rockytable values ('FreeBSD', 'yes', 'yes', 'yes');
INSERT INTO rockytable values ('Windows Server 2022', 'yes', 'yes', 'yes');
INSERT INTO rockytable values ('Manjaro', 'yes', 'no', 'no');
INSERT INTO rockytable values ('OpenSUSE', 'yes', 'no', 'no');
INSERT INTO rockytable values ('Debian', 'yes', 'no', 'no');
INSERT INTO rockytable values ('ZorinOS', 'no', 'no', 'no');
INSERT INTO rockytable values ('Kali Linux', 'no', 'no', 'no');
INSERT INTO rockytable values ('Alpine Linux', 'no', 'no', 'no');
```

Leamos la tabla:

```sql
SELECT * FROM rockytable;
```

![RockyDB](images/rocky_mariadb_select.png)

### Creando un usuario que pueda leer la tabla:

Ahora tenemos que crear un usuario y darle permisos para poder utilizarlo con el resto de software, como por ejemplo, un servidor PHP.

```sql
-- CREANDO EL USUARIO:
-- CREATE USER 'miusuario'@localhost IDENTIFIED BY 'mipassword';
CREATE USER 'phpuser'@localhost IDENTIFIED BY 'phpuser';

/* Ahora le podemos dar permisos para que acceda sólo desde esta máquina o para que acceda desde cualquier punto de la red */

-- Permisos desde la máquina:
-- GRANT USAGE ON *.* TO 'miusuario'@localhost IDENTIFIED BY 'mipassword';
GRANT USAGE, SELECT ON *.* TO 'phpuser'@localhost IDENTIFIED BY 'phpuser';

-- Permisos desde la red:
-- GRANT USAGE ON *.* TO 'miusuario'@'%' IDENTIFIED BY 'mipassword';
GRANT USAGE, SELECT ON *.* TO 'phpuser'@'%' IDENTIFIED BY 'phpuser';
```

En caso de querer darle todos los privilegios al usuario en cuestion, introduciríamos el siguiente comando. Esto no lo vamos a hacer porque sería bastante absurdo. Veamos el comando:

```sql
GRANT ALL privileges ON 'mibbdd'.* TO 'miusuario'@localhost;
```

Finalmente, aplicamos los cambios:

```sql
FLUSH PRIVILEGES;
EXIT;
```

Ahora lo suyo sería comprobar que funciona el usuario y que podemos leer la base de datos. Esto lo haríamos tal que así:

```bash
mysql -u phpuser -p
``` 

```sql
USE rockydb;
SELECT * FROM rockytable;
```

## Servidor Apache y PhpMyAdmin

Es interesante poder lanzar páginas web desde nuestro servidor, por lo que vamos a instalar Apache y lanzar dos webs. Una web nos mostrará la tabla de MariaDB que hemos creado en el punto anterior y otra web montará un CMS.

Para llevar a cabo todo esto, vamos a instalar Apache, PhpMyAdmin y todo el paquete PHP y, como CMS, Wordpress.

### Instalando Apache

Para poder llevar a cabo la implantación del servidor web, tendremos que habilitarlo. Para ello vamos a usar la siguiente batería de comandos:

```bash
# Actualizar sistema e instalar httpd
dnf update -y
dnf install -y httpd

# Habilitar servidor web
systemctl enable httpd
systemctl start httpd

# Permitir el paso a través del firewall
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
```

### Activando el modo debug en Apache

Para activar los logs de apache, tendremos que dirigirnos al archivo ```/etc/httpd/conf/httpd.conf``` y cambiar la línea siguiente:

```bash
# Línea original:
LogLevel warn

# Línea final:
LogLevel debug
```

### Instalación de PHP y phpMyAdmin

En esta herramienta va a ser necesaria para poder imprimir la base de datos en el navegador. Para instalar PHP vamos a usar la siguiente batería de comandos:

```bash
dnf module reset php
dnf module enable php:7.4
dnf install -y php php-common php-opcache php-cli php-gd php-curl php-mysqlnd php-xml
```

Ahora descargamos y descomprimimos phpMyAdmin:

```bash
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip
unzip phpMyAdmin-*-all-languages.zip

# Si unzip no está instalado lo instalamos así:
dnf install unzip -y
```

Ahora nos tocaría mover y cambiar de nombre el nuevo directorio con el siguiente comando:

```bash
mv phpMyAdmin-*-all-languages /usr/share/phpmyadmin
```

Una vez movido, cambiamos a dicho directorio y empezamos la configuración y puesta a punto de _phpMyAdmin_:

```bash
cd /usr/share/phpmyadmin
mv config.sample.inc.php config.inc.php
```

Ahora tendríamos que generar una clave de 32 bits, copiarla y añadirla en el archivo que hemos movido antes:

```bash
# Generar clave:
openssl rand -base64 32

# Abrir archivo:
nano config.inc.php

# Línea donde pegar la clave:
cfg['blowfish_secret'] = 'CLAVE';
```

Ahora tendríamos que crear un nuevo directorio temporal con los permisos necesarios usando los comandos siguientes:

```bash
mkdir /usr/share/phpmyadmin/tmp
chown -R apache:apache /usr/share/phpmyadmin
chmod 777 /usr/share/phpmyadmin/tmp
```

### Creando los archivos de configuración de Apache

El siguiente paso va a ser configurar Apache. Para ello abrimos el archivo ```/etc/httpd/conf.d/phpmyadmin.conf``` y pegamos el fragmento de texto siguiente:

```bash
Alias /phpmyadmin /usr/share/phpmyadmin
<Directory /usr/share/phpmyadmin/>
   AddDefaultCharset UTF-8
   <IfModule mod_authz_core.c>
     # Apache 2.4
     <RequireAny>
      Require all granted
     </RequireAny>
   </IfModule>
</Directory>

<Directory /usr/share/phpmyadmin/setup/>
   <IfModule mod_authz_core.c>
     # Apache 2.4
     <RequireAny>
       Require all granted
     </RequireAny>
   </IfModule>
</Directory>
```

Tras esto, escribimos el siguiente comando y reiniciamos el servicio de Apache:

```bash
chcon -Rv --type=httpd_sys_content_t /usr/share/phpmyadmin/*

systemctl restart httpd
```

Finalmente, podemos acceder a phpMyAdmin en la dirección ```http://MI_IP/phpmyadmin```:

![PhpMyAdmin](images/rocky_phpmyadmin.png)

### Creando VirtualHosts

Los _VirtualHosts_ son dominios ficticios alojados en un mismo servidor. Es decir, para una misma IP tendremos más de una página web. Lo primero que vamos a hacer con los hosts virtuales será crear las carpetas con las que vamos a trabajar, para ello usaremos el siguiente bloque de comandos:

```bash 
## Creando las carpetas
mkdir -p /var/www/databasereader.host/html
mkdir -p /var/www/chorizosalexa.es/html

## Cambiando el propietario a apache
chown -R apache:apache /var/www/databasereader.host/html
chown -R apache:apache /var/www/chorizosalexa.es/html

## Cambiando los permisos de las carpetas
chmod -R 755 /var/www
```

Ahora vamos a colocar una página de prueba en cada una de las carpetas en cuestión:

```bash
touch /var/www/databasereader.host/html/index.html
echo "Welcome to databasereader.host" >> /var/www/databasereader.host/html/index.html

touch /var/www/chorizosalexa.es/html/index.html
echo "Welcome to chorizosalexa.es" >> /var/www/chorizosalexa.es/html/index.html
```

Ahora tendríamos que habilitar estos host virtuales en el archivo de configuración. Para ello abrimos el archivo ```/etc/httpd/conf/httpd.conf``` y añadimos al final el bloque siguiente:

```bash
# DatabaseReader VirtualHost
<VirtualHost *:80>
  ServerName www.databasereader.host
  ServerAlias databasereader.host
  DocumentRoot /var/www/databasereader.host/html
  ErrorLog /var/www/databasereader.host/error.log
  CustomLog /var/www/databasereader.host/request.log combined
</VirtualHost>

# Chorizos Alexa VirtualHost
<VirtualHost *:80>
  ServerName www.chorizosalexa.es
  ServerAlias chorizosalexa.es
  DocumentRoot /var/www/chorizosalexa.es/html
  ErrorLog /var/www/chorizosalexa.es/error.log
  CustomLog /var/www/chorizosalexa.es/request.log combined
</VirtualHost>
```

Tras esto, tendremos que reiniciar Apache y nos saldrá un error que no nos permitirá volver a levantar el servidor, para corregir esto, tendremos que usar estos comandos y funcionará todo:

```bash
setenforce 0
systemctl restart httpd
systemctl status httpd
```

Este comando será para un funcionamiento temporal, por lo que tendremos que hacerlo permanente accediendo al archivo ```/etc/sysconfig/selinux``` y editando la línea siguiente:

```bash
# Línea original:
SELinux=enforcing

# Línea a establecer:
SELinux=permissive
```

Finalmente, reiniciamos el sistema.

Una vez tenemos el servidor web funcionando, tendremos que editar el archivo ```/etc/hosts``` y cambiar la línea del localhost tal que así:

```bash
# Línea original
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4

# Línea final
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 chorizosalexa.es www.chorizosalexa.es databasereader.host www.databasereader.host
```

Ahora podríamos acceder a las dos webs desde el navegador del servidor sin ningún problema.

Ahora bien, ¿y si queremos que nuestra web sea php? No habría ningún problema mientras PHP esté instalado en el servidor. Lo que tendríamos que hacer es cambiar el archivo ```index.html``` por un ```index.php``` y funcionaría igual.

### Creando una web en PHP que lea la base de datos

Una de las misiones que tenemos tras haber creado una base de datos en MariaDB o MySQL es mostrar la tabla que hemos creado en el navegador y esto lo podemos hacer mediante PHP. Para ello he preparado este archivo que guardaremos como index.php en el host virtual que corresponda:

```php
<!DOCTYPE HTML>
  <html>
  <body>
    <?php

      $hostname = "localhost";
      $username = "phpuser";
      $password = "phpuser";
      $db = "rockydb";

      $dbconnect=mysqli_connect($hostname,$username,$password,$db);

      if ($dbconnect->connect_error) {
        die("Database connection failed: " . $dbconnect->connect_error);
      }
    ?>

    <table border="1" align="center">
      <tr>
        <td>Operating System</td>
        <td>Used in P1</td>
        <td>Used in P2</td>
        <td>Used in P3</td>
      </tr>

      <?php
        $query = mysqli_query($dbconnect, "SELECT * FROM rockytable")
           or die (mysqli_error($dbconnect));

        while ($row = mysqli_fetch_array($query)) {
          echo
           "<tr>
              <td>{$row['opsys']}</td>
              <td>{$row['used_in_practice_1']}</td>
              <td>{$row['used_in_practice_2']}</td>
              <td>{$row['used_in_practice_3']}</td>
           </tr>\n";
        }
      ?>
    </table>
  </body>
</html>
```

Finalmente, reiniciamos el servidor web con ```systemctl restart httpd``` y volvemos a acceder a la web. Tendremos pintada la tabla de la base de datos que habríamos creado anteriormente. En caso de no salir la base de datos, pulsamos en el teclado ```CTRL + F5``` para que se refresque toda la página.

![Reading the database with php](images/rocky_phpreadsdatabase.png)

### Creando una segunda web con Wordpress

TODO

## TrueNAS + iSCSI

TrueNAS es un sistema operativo basado en FreeBSD dedicado a montar un servidor NAS 