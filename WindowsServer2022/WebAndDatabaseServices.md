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

### Creando un usuario phpuser

Ahora vamos a verificar que la base de datos funciona sin problemas, por lo que vamos a crear un usuario llamado _phpuser_ y una base de datos de pruebas.

Para acceder a Oracle usaremos el programa ```sqlplus``` desde powershell.

```sql
-- Creamos el usuario phpuser:
CREATE USER phpuser IDENTIFIED BY phpuser;
```