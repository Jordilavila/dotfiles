![Raspberry Pi OS](https://img.shields.io/badge/Raspberry%20Pi%20OS-C51A4A?style=for-the-badge&logo=Raspberry-Pi)  
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat-square&logo=mariadb&logoColor=white)

# NextCloud: Instalación y configuración de un Cloud propio con NextCloud

Debido a la cantidad de datos que generamos y la cantidad de información que queremos almacenar y tener disponible en la red, el uso de nuestra propia nube puede plantearse como una solución interesante.

Para poder llevar a cabo esta tarea necesitamos tener instalado [MariaDB](mariadb.md) y [Apache](webserverapache.md).

## Preparando un usuario y un grupo:

Debido a que tengo este NextCloud montado en mi Raspberry, he decidido crear un grupo nuevo y un usuario. Este usuario será con el que accederé al NextCloud, ya que no será un usuario administrador del sistema.

```bash
sudo addgroup nextcloudusers
sudo adduser --ingroup nextcloudusers NOMBRE_DE_USUARIO
```

## Preparando la base de datos:

El segundo paso de todo el montaje será crear la base de datos:

```bash
sudo mysql
```

```sql
CREATE DATABASE nextcloud_db;
CREATE USER 'nextcloud_user'@localhost identified by 'nextcloud_user';
GRANT ALL PRIVILEGES on nextcloud_db.* to 'nextcloud_user'@'localhost';
FLUSH PRIVILEGES;
```

Tras esto, ya tendríamos la base de datos lista.

## Descargando el server de NextCloud:

El siguiente paso es descargar el servidor de NextCloud. Para ello haremos lo siguiente:

```bash
cd /var/www/html
wget https://download.nextcloud.com/server/releases/latest.zip -O nextcloud_latest.zip
sudo unzip nextcloud_latest.zip
sudo chmod 755 nextcloud -R
```

Ahora, entra en la Raspberry desde el navegador tal que así: `IP_RPI/nextcloud` y configura el Nextcloud
