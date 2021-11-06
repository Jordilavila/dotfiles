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
