[![Windows Server](https://img.shields.io/badge/Windows%20Server-0078D6?style=for-the-badge&logo=windows&logoColor=white)](WindowsServer2022.md)
![Apache](https://img.shields.io/badge/apache-%23D42029.svg?style=for-the-badge&logo=apache&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![Oracle DB Express](https://img.shields.io/badge/Oracle%20DB%20Express-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![PHP](https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white)

# Servicios de Web y Base de datos

## Servidor Oracle DB Express

Igual que se creó PostgreSQL, tenemos Oracle Express, otro sistema para bases de datos relacionales. Oracle creó su propio lenguaje llamado _PL/SQL_.

### Instalando el servidor:

Para instalar Oracle DB Express nos lo tendremos que descargar de la prágina oficial, puesto que no está en Chocolatey. Para descargarlo usaremos el siguiente comando:

```powershell
# Lo descargamos 
wget https://download.oracle.com/otn-pub/otn_software/db-express/OracleXE213_Win64.zip -O ~/Downloads/OracleDBE.zip

# Lo descomprimimos
unzip OracleDBE.zip
```

Tras descomprimirlo se nos creará una carpeta donde tendremos el instalador de Oracle. Lo ejecutamos e instalamos el programa.

https://docs.oracle.com/cd/E17781_01/admin.112/e18585/toc.htm#XEGSG110

### Activando los logs en Oracle Express

Para activar los logs en Oracle Express tendremos que abrir el programa ```sqlplus``` y entrar como usuario ```sys```, cosa que no se nos permitirá hacer directamente. Para ello tendremos que decirle a Oracle que entre al usuario ```sys as sysdba```, y no pondrá ninguna pega.

Una vez dentro de Oracle tendremos que reiniciar la base de datos y activar los logs siguiendo estos comandos:

```sql
-- Desmontamos la base de datos:
SHUTDOWN IMMEDIATE;

-- Montamos la base de datos:
STARTUP MOUNT;

-- Verificamos el estado de los logs:
ARCHIVE LOG LIST;
    /*
        Si aquí nos dice que el MODO ARCHIVADO no está activo,
        significa que los logs no están activados.
    */

-- Activamos el modo archivado:
ALTER DATABASE archivelog;

-- Abrimos la base de datos:
ALTER DATABASE OPEN;

-- Volvemos a verificar el estado de los logs:
ARCHIVE LOG LIST;

-- Marcamos los logs al inicio:
ALTER SYSTEM ARCHIVE LOG START;
```

### Creando un usuario phpuser

Ahora vamos a verificar que la base de datos funciona sin problemas, por lo que vamos a crear un usuario llamado _phpuser_ y una base de datos de pruebas.

Para acceder a Oracle usaremos el programa ```sqlplus``` desde powershell.

```sql
-- Alteramos la sesión:
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- Creamos el usuario phpuser:
CREATE USER phpuser IDENTIFIED BY phpuser;

-- Otorgamos los permisos necesarios:
GRANT CREATE SESSION TO phpuser;
GRANT ALL PRIVILEGES TO phpuser;
```

Ahora tendríamos que abrir una sesión con la cuenta que hemos creado y crear una tabla nueva:

```sql
CREATE TABLE wintable (
    opsys varchar2(100) constraint pk_wintable primary key,
    used_in_practice_1 varchar2(20),
    used_in_practice_2 varchar2(20),
    used_in_practice_3 varchar2(20)
);

INSERT INTO wintable values ('Rocky Linux', 'yes', 'yes', 'yes');
INSERT INTO wintable values ('FreeBSD', 'yes', 'yes', 'yes');
INSERT INTO wintable values ('Windows Server 2022', 'yes', 'yes', 'yes');
INSERT INTO wintable values ('Manjaro', 'yes', 'no', 'no');
INSERT INTO wintable values ('OpenSUSE', 'yes', 'no', 'no');
INSERT INTO wintable values ('Debian', 'yes', 'no', 'no');
INSERT INTO wintable values ('ZorinOS', 'no', 'no', 'no');
INSERT INTO wintable values ('Kali Linux', 'no', 'no', 'no');
INSERT INTO wintable values ('Alpine Linux', 'no', 'no', 'no');
```

Leamos la tabla:

```sql
SELECT * FROM wintable;
```

![WinDB](images/ws_oracleexpress_select.png)

### Instalando el Servidor IIS

_Internet Information Server_ (IIS) es un servidor web que provee un conjunto de servicios para sistemas operativos Windows. IIS ofrece soporte para los protocolos HTTP, HTTPS, FTP, FTPS, SMTP y NNTP. Resumidamente, es un Apache o NGinx versión Microsoft.

Para activar el servidor IIS tendremos que acceder al panel de administración del servidor, entrar en la opción de agregar roles y características y activar el servidor IIS. Además, es recomendable activar estas opciones:

TODO https://perez987.es/instalar-php-en-iis-de-windows-10/

![ISS Options](images/ws_iis_servicios_rol.png)

Finalmente, podemos probar la instalación accediendo a _localhost_ desde el navegador del servidor y desde un cliente.

### Configurando un VirtualHost

La configuración no tiene pérdida. Se lleva a cabo desde el _Administrador de Internet Information Services_. Sólo tendremos que hacer click derecho sobre la capeta _sitios_ (situada en la parte izquierda) y seleccionar la opción de _Agregar sitio web_. Tras esto lo único que tendremos que hacer es seguir los pasos.

![ISS ADD VIRTUALHOST](images/ws_add_virtualhost.png)

Previamente tendremos que tener creadas las carpetas de los dominios virtuales en la ruta ```C:/inetpub/wwwroot/```.

Ahora tendremos que modificar el archivo ```C:/Windows/System32/drivers/etc/hosts``` y le añadiremos lo siguiente:

```bash
127.0.0.1   www.MIWEB.com
```

### Instalación de PHP

Las últimas versiones de PHP que se podían instalar con un instalador _.msi_ se quedaron la versión 5. Actualmente está la versión 8, que es la que vamos a instalar. La instalación de PHP se hace descargando un archivo _.zip_ y descomprimiéndolo en el disco duro, configurando el _PATH_ del sistema y bla bla bla. 

Olvídate:

```powershell
choco install -y php
```

PHP instalado y preparado. Ahora toca revisar la configuración de PHP. Tendremos que acceder al archivo _PHP.ini_, ubicado en la ruta ```C:/tools/php80```.

- Descomentar el directorio de extensiones:

    ```powershell
        fastcgi.impersonate = 1
        cgi.fix_pathinfo = 0
        cgi.force_redirect = 0
        open_basedir = "C:\inetpuc\wwwroot"
        error_log = php_errors.log
        extension_dir = "ext"
    ```

- Asegurarnos de habilitar las extensiones siguientes:

    ```powershell
        extension=curl
        extension=fileinfo
        extension=gd
        extension=intl
        extendion=mbstring
        extension=oci8_19
        extension=odbc
        extension=openssl
        extension=pdo_mysql
        extension=pdo_oci
        extension=pdo_odbc
    ```

¿Cómo podemos establecer que IIS abra por defecto un archivo _.php_? Muy sencillo: en la configuración del sitio accedemos a la opción de _documento predeterminado_ y añadimos _index.php_.

Ahora bien, para leer con PHP la base de datos que hemos creado, usamos el siguiente script:

```php
<!DOCTYPE HTML>
<html>

<body>
  <center>
    <?php
    $db_user = "phpuser";
    $db_pass = "phpuser";
    $conexión = oci_connect($db_user, $db_pass, 'localhost/XE');
    if (!$conexión) {
      $e = oci_error();
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    // Preparar la sentencia
    $stid = oci_parse($conexión, 'SELECT * FROM wintable');
    if (!$stid) {
      $e = oci_error($conexión);
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    // Realizar la lógica de la consulta
    $r = oci_execute($stid);
    if (!$r) {
      $e = oci_error($stid);
      trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

    // Obtener los resultados de la consulta
    print "<table border='1'>\n";
    while ($fila = oci_fetch_array($stid, OCI_ASSOC + OCI_RETURN_NULLS)) {
      print "<tr>\n";
      foreach ($fila as $elemento) {
        print "    <td>" . ($elemento !== null ? htmlentities($elemento, ENT_QUOTES) : "") . "</td>\n";
      }
      print "</tr>\n";
    }
    print "</table>\n";

    oci_free_statement($stid);
    oci_close($conexión);

    ?>
  </center>
</body>

</html>
```

Finalmente, el resultado es el siguiente:

![PHP DB](images/ws_dbtest.png)
