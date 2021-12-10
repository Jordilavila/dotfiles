![Free BSD](https://img.shields.io/badge/FreeBSD-B50000?style=for-the-badge&logo=freebsd&logoColor=white)

# Nagios

Nagios es un sistema de monitorización de redes que vigila los equipos y los servicios que se especifiquen, alertando cuando el comportamiento de los mismos no sea el deseado. Entre sus características principales figuran la monitorización de servicios de red, la monitorización de los recursos de sistemas hardware (carga de la cpu, uso de discos, etc.), independencia de sistemas operativos, etc.

Este software es bastante versátil para consultar prácticamente cualquier parámetro de interés de un sistema, y genera alertas que se pueden recibir por email y SMS. Otro dato interesante es que se consulta en una web en PHP que montamos en el servidor.

Para instalar Nagios, podremos hacerlo con un script que he preparado o paso por paso.

## Preparando las dependencias

### Usando el script

Para usar el script será tan sencillo como hacer uso de los siguientes comandos:

```bash
# Run as root
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/FreeBSD/install_files/install_nagios.sh
sh install_nagios.sh
```

El script acaba con la descompresión de la carpeta de Nagios.

### Usando los comandos

Lo primero que haremos será una actualización del sistema y luego instalaremos las dependencias. Exactamente igual que se haría con el script:

```bash
# Instalación de dependencias:
pkg install apache24 mod_php74 php74-gd php74-mysqli php74 mariadb105-server
service apache24 enable
service apache24 restart
service mysql-server enable
service mysql-server restart

mysql_secure_installation

cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
rehash
```

Una vez instalados Apache, PHP y MariaDB, configuraremos PHP para que trabaje con Apache (```/usr/local/etc/apache24/modules.d/001_mod-php.conf```):

```bash
<IfModule dir_module>
    DirectoryIndex index.php index.html
    <FilesMatch "\.php$">
        SetHandler application/x-httpd-php
    </FilesMatch>
    <FilesMatch "\.phps$">
        SetHandler application/x-httpd-php-source
    </FilesMatch>
</IfModule>
```

Tras esto, es conveniente comprobar que todo funciona:

```bash
apachectl configtest # Se espera: Syntax OK
apachectl restart
```

Ahora instalamos Nagios:

```bash
pkg install -y nagios4
```

Ahora nos tocará preparar los archivos. Tan sencillo como esto:

```bash
cd /usr/local/etc/nagios
cp cgi.cfg-sample cgi.cfg
cp nagios.cfg-sample nagios.cfg
cp resource.cfg-sample resource.cfg
cd objects
cp commands.cfg-sample commands.cfg
cp contacts.cfg-sample contacts.cfg
cp localhost.cfg-sample localhost.cfg
cp printer.cfg-sample printer.cfg
cp switch.cfg-sample switch.cfg
cp templates.cfg-sample templates.cfg
cp timeperiods.cfg-sample timeperiods.cfg
chmod -R 777 /user/local/etc/nagios
```

Ahora tenemos que abrir el archivo ```/usr/local/etc/apache24/httpd.conf``` y añadirle al final todo esto:

```bash
<FilesMatch "\.php$">
    SetHandler application/x-httpd-php
</FilesMatch>

<FilesMatch "\.phps$">
    SetHandler application/x-httpd-php-source
</FilesMatch>

<Directory /usr/local/www/nagios>
    AllowOverride None
    Order deny, allow
    Deny from all
    Allow from all
    php_flag engine on
    php_admin_value open_basedir /usr/local/www/nagios/:/var/spool/nagios
    AuthName "admin"
    AuthType Basic
    AuthUserFile /usr/local/etc/nagios/htpasswd.users
    Require valid-user
</Directory>

<Directory /usr/local/www/nagios/cgi-bin>
    Options ExecCGI
</Directory>

ScriptAlias /nagios/cgi-bin/ /usr/local/www/nagios/cgi-bin/
Alias /nagios /usr/local/www/nagios/
```

A parte, en la línea 161 tendremos que descomentar esto:

```bash
<IfModule !mpm_prefork_module>
    LoadModule cgid_module libexec/apache24/mod_cgid.so
</IfModule>

<IfModule mpm_prefork_module>
    LoadModule cgi_module libexec/apache24/mod_cgi.so
</IfModule>
```

Ahora añadimos un usuario admin para la interfaz de nagios:

```bash
htpasswd -c /usr/local/etc/nagios/htpasswd.users nagiosadmin
```

El siguiente paso será habilitar nagios y reiniciarlo:

```bash
service nagios enable
service nagios restart
```

Finalmente, ya podremos acceder a la interfaz de nagios desde el navegador.
