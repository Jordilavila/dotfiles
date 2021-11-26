![Raspberry Pi OS](https://img.shields.io/badge/Raspberry%20Pi%20OS-C51A4A?style=for-the-badge&logo=Raspberry-Pi)  
![Apache](https://img.shields.io/badge/Apache-%23D42029.svg?style=flat-square&logo=apache&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-%23777BB4.svg?style=flat-square&logo=php&logoColor=white)

# Apache: Un servidor web en nuestra Raspberry Pi

Es interesante poder lanzar páginas web desde nuestro servidor, por lo que vamos a instalar Apache y lanzar dos webs. Una web nos mostrará un CMS como Wordpress y la otra un NextCloud.

Para llevar a cabo todo esto, vamos a instalar Apache, todo el paquete PHP y Wordpress.

:warning: Se recomienda instalar primero MariaDB, podemos ver el tutorial [aquí](mariadb.md).

## Instalaciones:

Instalación de Apache:

```bash
sudo apt install apache2
```

Instalación de PHP:

```bash
sudo apt install -y php
```

## Creando los directorios de las webs en Apache:

Vamos a crear un directorio para NextCloud y otro para nuestra web:

```bash
sudo mkdir /var/www/elcontent.net
sudo mkdir /var/www/elcontent.cloud
```

Tras esto ya podemos pasar a configurar los VirtualHosts.

## Configurando los VirtualHosts:

Para configurar los VirtualHosts, vamos a cambiarnos a la carpeta de los sitios web disponibles: ```cd /etc/apache2/sites-available```

Ahora vamos a copiarnos el archivo de ejemplo y lo editaremos a nuestro gusto:

```bash
sudo cp 000-default.conf elcontent.net
```

Ahora lo podemos editar. En mi caso quedaría así:

```bash
<VirtualHost*:80>
    ServerAdmin webmaster@localhost
    ServerName elcontent.net
    ServerAlias www.elcontent.net
    DocumentRoot /var/www/elcontent.net
    ErrorLog ${APACHE_LOG_DIR}/error_elcontentnet.log
    CustomLog ${APACHE_LOG_DIR}/access_elcontentnet.log combined
</VirtualHost>
```

Ahora nos tocaría habilitar nuestro sitio con el comando ```a2ensite```:

```bash
sudo a2ensite elcontent.net
```

Y, ahora, anulamos el que viene por defecto con el comando:

```bash
sudo a2dissite 000-default.conf
```

Finalmente, reiniciamos Apache:

```bash
sudo systemctl restart apache2
```

Para comprobar que todo funciona crearemos en ```/var/www/elcontent.net``` el archivo ```index.php``` con el siguiente código:

```php
<?php
    phpinfo();
?>
```

Ahora cambiamos los permisos y la propiedad:

```bash
sudo chown -R www-data:www-data /var/www/elcontent.net
sudo find /var/www/elcontent.net -type d -exec chmod 750 {} \;
sudo find /var/www/elcontent.net -type f -exec chmod 640 {} \;
```

## Instalación de Wordpress

Para instalar Wordpress tendremos que descargarlo. Para ello, propongo lo siguiente:

```bash
su
cd /var/www/elcontent.net
rm index.php
wget https://es.wordpress.org/latest-es_ES.zip -O wordpress.zip
unzip wordpress.zip
```
