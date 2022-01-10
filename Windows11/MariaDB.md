# Instalación y puesta a punto de MariaDB

Vamos a instalar y configurar MariaDB porque necesitamos este servidor de bases de datos para poder trabajar con CMS como WordPress o Joomla. Para llevar a cabo su instalación será tan simple como instalarlo con Chocolatey:

```powershell
choco install -y mariadb
```

Ahora procedemos a configurar MariaDB. Para ello habrá que entrar con ```mysql -u root``` y hacer los siguientes pasos:

```sql
-- Estableciendo una contraseña para el usuario root:
ALTER USER 'root'@'localhost' IDENTIFIED BY 'PASSWORD';
```

Una vez que hemos cambiado la constraseña es interesante verificar que funciona. Tras esto, continuamos:

```sql
-- HABILITAMOS LOS LOGS
-- Indicamos que la salida de los logs será en un archivo:
SET GLOBAL log_output = 'FILE';

-- Especificamos la ruta del archivo donde se guardarán los logs:
SET GLOBAL general_log_file='C:\logs\mariadb\mariadb.log';

-- Habilitamos los logs
SET GLOBAL general_log = 'ON';
```

Tras esto, ya tenemos MariaDB configurado