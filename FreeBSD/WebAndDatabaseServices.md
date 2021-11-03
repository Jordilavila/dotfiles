[![Free BSD](https://img.shields.io/badge/FreeBSD-EE0000?style=for-the-badge&logo=freebsd&logoColor=white)](FreeBSD.md)
![Apache](https://img.shields.io/badge/apache-%23D42029.svg?style=for-the-badge&logo=apache&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![PHP](https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white)
![Joomla](https://img.shields.io/badge/joomla-%23156BE9.svg?style=for-the-badge&logo=Joomla&logoColor=white)

# Servicios de Web y Base de datos

## Servidor PostgreSQL

## Servidor Apache

Es interesante poder lanzar páginas web desde nuestro servidor, por lo que vamos a instalar Apache y lanzar dos webs. Una web nos mostrará la tabla de MariaDB que hemos creado en el punto anterior y otra web montará un CMS.

Para llevar a cabo todo esto, vamos a instalar Apache, PhpMyAdmin y todo el paquete PHP y, como CMS, Wordpress.

### Instalando Apache

Para poder llevar a cabo la implantación del servidor web, tendremos que habilitarlo. Para ello vamos a usar la siguiente batería de comandos:

```bash
# Instalación de la paquetería necesaria:
pkg install -y apache24 openssl

# Habilitando y arrancando el servidor:
service apache24 enable
service apache24 start

# Aviso: Puede que salten warnings, que no cunda el pánico
```

### Activando el modo debug en Apache

Para activar los logs de apache, tendremos que dirigirnos al archivo ```/usr/local/etc/apache24/httpd.conf``` y cambiar la línea siguiente:

```bash
# Línea original:
LogLevel warn

# Línea final:
LogLevel debug
```

### Configurando los VirtualHosts

Los _VirtualHosts_ son dominios ficticios alojados en un mismo servidor. Es decir, para una misma IP tendremos más de una página web. Lo primero que vamos a hacer con los hosts virtuales será crear las carpetas con las que vamos a trabajar, para ello usaremos el siguiente bloque de comandos:

```bash 
## Creando las carpetas
mkdir -p /usr/local/docs/databasereader.host/public_html
mkdir -p /usr/local/docs/chorizosalexa.es/public_html
mkdir -p /var/log/databasereader.host/
mkdir -p /var/log/chorizosalexa.es/

## Cambiando los permisos de las carpetas
chmod -R 755 /usr/local/docs
```

Ahora tocaría acceder de nuevo al archivo de configuración de Apache para habilitar la inclusión del archivo externo donde especificaremos los VirtualHosts:

```bash
# Acceso al archivo:
nano /usr/local/etc/apache24/httpd.conf

### Bloque original:
# Virtual hosts
#Include etc/apache24/extra/httpd-vhosts.conf

# Virtual hosts
Include etc/apache24/extra/httpd-vhosts.conf
```

Ahora tendríamos que guardarnos una copia del archivo de los virtual hosts y luego abrir el archivo:

```bash
# Guardando una copia:
cp /usr/local/etc/apache24/extra/httpd-vhosts.conf /usr/local/etc/apache24/extra/httpd-vhosts.conf.backup

# Abriendo el archivo original:
nano /usr/local/etc/apache24/extra/httpd-vhosts.conf
```

Una vez hemos abierto el archivo original, yo le he añadido estos VirtualHosts:

```bash
# DatabaseReader VirtualHost
<VirtualHost *:80>
  ServerName www.databasereader.host
  ServerAlias databasereader.host
  DocumentRoot /usr/local/docs/databasereader.host/public_html
  ErrorLog /var/log/databasereader.host/error.log
  CustomLog /var/log/databasereader.host/request.log common
</VirtualHost>

# Chorizos Alexa VirtualHost
<VirtualHost *:80>
  ServerName www.chorizosalexa.es
  ServerAlias chorizosalexa.es
  DocumentRoot /usr/local/docs/chorizosalexa.es/public_html
  ErrorLog /var/log/chorizosalexa.es/error.log
  CustomLog /var/log/chorizosalexa.es/request.log common
</VirtualHost>
```

https://comoinstalar.me/como-instalar-apache-en-freebsd-12/