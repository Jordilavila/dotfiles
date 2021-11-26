![Raspberry Pi OS](https://img.shields.io/badge/Raspberry%20Pi%20OS-C51A4A?style=for-the-badge&logo=Raspberry-Pi)  
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat-square&logo=mariadb&logoColor=white)

# MariaDB: Instalación y configuración del clásico servidor de bases de datos

## Instalación de MariaDB

Para instalar MariaDB haremos uso del siguiente comando:

```bash
sudo apt install -y mariadb-server
```

Tras la descarga, tendremos que hacer la instalación:

```bash
sudo mysql_secure_installation
```

Ahora podemos descargar el complemento de PHP:

```bash
sudo apt install php-mysql
```

Finalmente, reiniciamos el servidor Apache:

```bash
sudo systemctl restart apache2
``` 

## Creando una base de datos para Wordpress:

```bash
sudo mysql
```

```sql
CREATE DATABASE wordpress;
CREATE USER 'wp_user'@localhost IDENTIFIED BY 'wp_psswd';
GRANT ALL privileges ON wordpress.* TO 'wp_user'@localhost;
```
