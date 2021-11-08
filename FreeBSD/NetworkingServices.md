[![Free BSD](https://img.shields.io/badge/FreeBSD-B50000?style=for-the-badge&logo=freebsd&logoColor=white)](FreeBSD.md)

# Servicios de Red

## DHCP

## DNS

## GIT

GIT es un software de control de versiones diseñado por Linus Torvalds, pensando en la eficiencia, la confiabilidad y compatibilidad del mantenimineto de versiones de aplicaciones cuando estas tienen un gran número de archivos de código fuente.

### Instalación y configuración de GIT

Para llevar a cabo la instalación de un servidor GIT en FreeBSD seguiremos los pasos siguientes:

```bash
# Actualizar el sistema:
pkg update && pkg upgrade -y

# Instalar GIT
pkg install -y git

# Creamos el usuario git:
pw user add git -m -s /usr/local/bin/bash

# Estableciendo una contraseña para el usuario git:
passwd git
```

También tenemos que crear las carpetas que vamos a utilizar:

```bash
mkdir -p /home/git/.ssh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub > /home/git/.ssh/authorized_keys
chown -R git:git /home/git/.ssh
chmod 0700 /home/git/.ssh
chmod 0600 /home/git/.ssh/authorized_keys
```

Finalmente tocaría habilitar los servicios:

```bash 
# Habilitamos el servicio
sysrc git_daemon_enable="YES" && service git_daemon start
```

Para terminar, entramos en el usuario git y creamos los directorios requeridos y montamos el servidor:

```bash
su git
cd /home/git
mkdir -p Projects
cd Projects
git init --bare --shared
```

Tras esto nuestro servidor Git en FreeBSD estará funcionando y nos podremos guardar nuestras cosas en él.

### Comandos de git

Por recordar algunos comandos de Git:

```bash
# Iniciar un repositorio en el directorio actual
git init 

# Conectarse a un repositorio remoto
git remote add origin git@SERVER_NAME_OR_IP:/home/git/Projects

# Sincronizarse con el repositorio remoto
git fetch origin

# Comprobar el estado del repositorio local
git status

# Descargar archivos remotos
git pull origin

# Subir archivos locales 
git push

# Añadir archivos al stash 
git add ARCHIVO

# Hacer un commit
git commit -m "MENSAJE DEL COMMIT"
```

## OwnCloud

Estamos acostumbrados a utilizar los servicios en la nube de Dropbox, OneDrive, Google, Amazon, etc. Pero, ¿y si nos creamos nuestra propia nube privada? Pues es posible, tan solo necesitamos _OwnCloud_.

_OwnCloud_ es una aplicación de software libre que permite el almacenamiento en línea y aplicaciones en línea. Lo podemos instalar un servidor que disponga de una versión reciente de PHP y con soporte de SQLite, MySQL/MariaDB o PostgreSQL, lo que cumple con los requisitos para instalarlo en nuestro servidor FreeBSD.

Los requisitos para llevar a cabo la instalación de _OwnCloud_ en nuestro caso, son los siguientes:

- MariaDB o MySQL
- Apache
- Un VirtualHost en Apache para _OwnCloud_
- PHP

### Creando la base de datos

Lo primero será crear la base de datos con MariaDB. Para ello nos loguearemos con ```mysql -u root -p``` usaremos los siguientes comandos:

```sql
CREATE USER 'ownclouduser'@localhost IDENTIFIED BY 'ownclouduser';
CREATE DATABASE owncloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL ON owncloud.* TO 'ownclouduser'@'localhost' IDENTIFIED BY 'ownclouduser';
EXIT;
```

### Descargando OwnCloud

Para descargar _OwnCloud_ vamos a realizar lo siguiente:

```bash
wget https://download.owncloud.org/community/owncloud-complete-20210721.zip -O owncloud.zip
unzip owncloud.zip -d /usr/local/docs/minube.com/
```

Ahora podríamos entrar en la dirección web que tenemos configurada para instalar OwnCloud en nuestro servidor, pero no lo vamos a lograr porque la última versión de OwnCloud no es compatible con FreeBSD.

