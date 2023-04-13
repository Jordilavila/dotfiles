# Plataforma de Votaciones Electrónica (PVE)

La Plataforma de Votaciones Electrónica (PVE) o más conocida como la Plataforma de Debates RITSI es una herramienta que permite la moderación de debates en tiempo real. Esta herramienta ha sido desarrollada por la Comisión de Infraestructuras y Comunicaciones de la RITSI.

La Plataforma de Debates se lleva utilizando desde hace tiempo para facilitar el desarrollo de las asambleas de la RITSI. Sin embargo, esta plataforma aún tiene margen de mejora.

Este documento pretende ser una guía para la instalación y configuración de la Plataforma de Debates RITSI. Esta guía está pensada para ser utilizada por los miembros de la Comisión de Infraestructuras y Comunicaciones de la RITSI. Además, esta guía está pensada para ser utilizada en un entorno de desarrollo local.

Por último, esta guía también pretende explicar las funcionalidades básicas de la Plataforma de Debates RITSI.

Esta guía la escribe [Jordi S. Enríquez](https://github.com/Jordilavila) de _RITSI para RITSI_. Si tienes alguna duda o sugerencia, puedes contactar conmigo a través de mi perfil de GitHub o por Telegram.

## :page_with_curl: Índice

* [Plataforma de Votaciones Electrónica (PVE)](#plataforma-de-votaciones-electrónica-pve)
  * [:page_with_curl: Índice](#page_with_curl-índice)
  * [:hammer_and_wrench: Instalación](#hammer_and_wrench-instalación)
    * [Instalación de WSL2 y Ubuntu en Windows 11](#instalación-de-wsl2-y-ubuntu-en-windows-11)
      * [:one: Habilitar WSL2](#one-habilitar-wsl2)
      * [:two: Instalar Ubuntu](#two-instalar-ubuntu)
      * [:three: Instalación de dependencias](#three-instalación-de-dependencias)
      * [:four: Creación de la base de datos MySQL](#four-creación-de-la-base-de-datos-mysql)
    * [Conexión de Visual Studio Code con Ubuntu](#conexión-de-visual-studio-code-con-ubuntu)
    * [Configuración de la Plataforma de Debates RITSI](#configuración-de-la-plataforma-de-debates-ritsi)
    * [Instalación de la Plataforma de Debates RITSI](#instalación-de-la-plataforma-de-debates-ritsi)
  * [:clipboard: Comandos relevantes de Laravel](#clipboard-comandos-relevantes-de-laravel)
  * [:warning: Acceso en desarrollo a la Plataforma de Debates RITSI](#warning-acceso-en-desarrollo-a-la-plataforma-de-debates-ritsi)
  * [:memo: Uso de la Plataforma de Debates RITSI](#memo-uso-de-la-plataforma-de-debates-ritsi)
    * [:cop: Usuario administrador](#cop-usuario-administrador)
    * [:busts_in_silhouette: Usuario moderador](#busts_in_silhouette-usuario-moderador)
    * [:smiley: Usuario normal](#smiley-usuario-normal)
      * [Turnos de palabra](#turnos-de-palabra)
      * [Navegación por la barra superior](#navegación-por-la-barra-superior)
      * [Perfil](#perfil)

## :hammer_and_wrench: Instalación

En esta sección vamos a ver la instalación de las dependecias de la Plataforma de Debates RITSI. Se recomienda realizar la instalación en una máquina virtual de Debian o cualquier distribución basada en Debian, como Ubuntu. En este caso, se ha utilizado una máquina virtual Ubuntu corriendo en la WSL2 de Windows 11. Esta última opción es la más cómoda y recomendada.

### Instalación de WSL2 y Ubuntu en Windows 11

Para instalar WSL2 en Windows 11 se necesita tener el sistema actualizado y seguir los pasos detallados a continuación:

#### :one: Habilitar WSL2

Para habilitar WSL2 en Windows 11 se debe abrir una terminal de PowerShell como administrador y ejecutar el siguiente comando:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

Otra opción es habilitar WSL2 desde el panel de control de Windows 11. Para ello, buscamos las _características de Windows_ y habilitamos las siguientes opciones:

* Subsistema de Windows para Linux
* Plataforma de virtualización de Windows
* Subsistema de Windows para Linux

Finalmente, reiniciamos el sistema.

#### :two: Instalar Ubuntu

Para llevar a cabo la instalación de Ubuntu en Windows 11 tenemos dos opciones:

* Instalar Ubuntu desde la Microsoft Store
* Instalar Ubuntu desde la PowerShell

Antes de hacer nada, debemos asegurarnos de que las instalaciones de WSL serán por defecto en WSL2. Para ello, abrimos una terminal de PowerShell como administrador y ejecutamos el siguiente comando:

```powershell
wsl --set-default-version 2
```

En este caso, se ha optado por la segunda opción. Para ello, abrimos una terminal de PowerShell como administrador y ejecutamos el siguiente comando:

```powershell
wsl --install -d Ubuntu
```

En caso de querer ver las distribuciones disponibles, podemos ejecutar el siguiente comando:

```powershell
wsl --list --online
```

Para verificar que la instalación se ha realizado correctamente, podemos ejecutar el siguiente comando:

```powershell
wsl -l -v
```

El comando anterior nos mostrará las distribuciones instaladas y la versión de WSL que se está utilizando. En caso de que no esté montada la máquina virtual con la versión de WSL2, se puede montar con el siguiente comando:

```powershell
wsl --set-version Ubuntu 2
```

A veces podemos tener varias máquinas WSL2 instaladas y necesitamos una por defecto. Para establecer la WSL2 por defecto, podemos ejecutar el siguiente comando:

```powershell
wsl --set-default Ubuntu
```

Hasta aquí, ya tenemos instalada la WSL2 y Ubuntu en Windows 11.

Para acceder a la máquina virtual de Ubuntu, podemos ejecutar el siguiente comando:

```powershell
ubuntu
```

La primera vez que ejecutamos el comando anterior, nos pedirá que creemos un usuario y una contraseña. Una vez creados, ya podemos acceder a la máquina virtual de Ubuntu con total normalidad.

El siguiente paso es actualizar la máquina virtual de Ubuntu. Para ello, ejecutamos el siguiente comando:

```bash
sudo apt update && sudo apt upgrade -y
```

El siguiente paso será habilitar _systemd_ en la máquina virtual de Ubuntu. Para ello, tendremos que editar el fichero de configuración de la WSL2. Para ello, ejecutamos el siguiente comando:

```bash
sudo nano /etc/wsl.conf
```

Y añadimos las siguientes líneas:

```bash
[boot]
systemd=true
```

Guardamos el fichero y cerramos la máquina virtual de Ubuntu. Ahora tendremos que reiniciar la WSL desde la PowerShell. Para ello, ejecutamos el siguiente comando:

```powershell
wsl --shutdown
```

Y, por último, volvemos a abrir la máquina virtual de Ubuntu. Ahora tenemos nuestra máquina virtual de Ubuntu lista para instalar las dependencias de la Plataforma de Debates RITSI.

#### :three: Instalación de dependencias

Ahora vamos a instalar las dependencias necesarias para la Plataforma de Debates RITSI. Instalaremos:

* Git
* PHP 7.1
* Composer
* MySQL

Y, como no, utilizaremos el editor de texto Visual Studio Code en Windows 11 para editar los archivos de la Plataforma de Debates RITSI. En otro punto de esta guía veremos cómo conectar Visual Studio Code con la máquina virtual de Ubuntu.

Ahora sí, vamos a instalar las dependencias. Para ello, ejecutamos el siguiente comando:

```bash
sudo apt install git mysql-server curl
```

Una vez instalados los paquetes anteriores, instalaremos PHP 7.1:

```bash
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update -y
sudo apt install -y php7.1 php7.1-mysql php7.1-curl php7.1-mbstring php7.1-xml
```

Una vez instalado PHP 7.1, instalaremos Composer:

```bash
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
```

Ahora ya tenemos instaladas todas las dependencias necesarias para la Plataforma de Debates RITSI. ¡Enhorabuena!

#### :four: Creación de la base de datos MySQL

No nos podemos olvidar de crear la base de datos y el usuario de MySQL. Previamente a la creación de la base de datos y el usuario, debemos habilitar el servicio de MySQL. Para ello, ejecutamos el siguiente comando:

```bash
sudo systemctl enable mysql
```


Para ello, en la máquina virtual de Ubuntu, ejecutamos el siguiente comando:

```bash
sudo mysql
```

Una vez dentro de MySQL, ejecutamos el siguiente comando:

```sql
CREATE DATABASE db_debates;
CREATE USER 'debates'@'localhost' IDENTIFIED BY 'debates';
GRANT ALL PRIVILEGES ON db_debates.* TO 'debates'@'localhost';
FLUSH PRIVILEGES;
```

Ahora ya tenemos la base de datos y el usuario de MySQL creados.

### Conexión de Visual Studio Code con Ubuntu

Para conectar Visual Studio Code con Ubuntu, tenemos que instalar la extensión _Remote - WSL_ en Visual Studio Code. Una vez instalada, abrimos Visual Studio Code, abrimos la carpeta del proyecto y hacemos click en el botón verde que aparece en la esquina inferior izquierda de la pantalla. En el menú que aparece, seleccionamos _Remote-WSL: Reopen in WSL_. En este momento, Visual Studio Code reabrirá el directorio en el que nos encontramos en la máquina virtual de Ubuntu.

En la siguiente imagen se puede ver el botón verde que aparece en la esquina inferior izquierda de la pantalla:

<div style="text-align:center">
    <img src="./documentacion/captura_wsl_vscode.png" />
</div>

El menú que aparece al hacer click en el botón verde es el siguiente:

<div style="text-align:center">
    <img src="./documentacion/captura_wsl_vscode_menu.png" />
</div>

### Configuración de la Plataforma de Debates RITSI

Ahora volvemos a nuestro VSCode en Windows 11 y hacemos click en la parte superior, en el menú _Terminal_ y seleccionamos _New Terminal_. En la terminal que se abre, ejecutamos el siguiente comando:

```bash
cp .env.example .env
```

Este comando copia el archivo _.env.example_ en un archivo _.env_. Ahora tenemos que editar el archivo _.env_ para que se adapte a nuestro entorno. Para ello, lo abrimos con VSCode y editamos las líneas de la configuración de la base de datos para que queden tal que así:

```bash
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=db_debates
DB_USERNAME=debates
DB_PASSWORD=debates
```

Una vez que ya tenemos el archivo _.env_ configurado, ¡enhorabuena! Ya tenemos todo listo para instalar la Plataforma de Debates RITSI.

### Instalación de la Plataforma de Debates RITSI

Este proceso va a ser muy largo y sencillo a la vez. Lo primero que tenemos que hacer es instalar las dependencias de PHP. Para ello, ejecutamos el siguiente comando:

```bash
composer install
```

Ahora relájate y disfruta de un café mientras se instalan las dependencias de PHP. Incluso puedes ir a por un segundo café o jugarte una partida al LoL mientras se instalan las dependencias de PHP. ¡No te preocupes! El proceso de instalación de las dependencias de PHP es muy largo.

Una vez que se hayan instalado las dependencias de PHP, ejecutamos el siguiente comando:

```bash
php artisan migrate
php artisan db:seed
```

El primer comando ejecuta las migraciones de la base de datos y el segundo comando ejecuta los seeders de la base de datos. Una vez que se hayan ejecutado los comandos anteriores, ejecutamos el siguiente comando:

```bash
php artisan serve
```

Este último comando ejecuta el servidor de PHP. Así que, ¡ya tenemos la Plataforma de Debates RITSI instalada y funcionando! ¡Enhorabuena!

## :clipboard: Comandos relevantes de Laravel

Mira, aquí te dejo una tabla con los comandos que considero más relevantes de Laravel. Si quieres saber más sobre los comandos de Laravel, puedes consultar la [documentación oficial](https://laravel.com/docs/).

| Comando | Descripción |
| :--- | :--- |
| `php artisan serve` | Ejecuta el servidor de PHP. |
| `php artisan make:controller NombreController` | Crea un controlador cuyo nombre es _NombreController_. |
| `php artisan make:model NombreModel` | Crea un modelo cuyo nombre es _NombreModel_. |
| `php artisan make:migration NombreMigration` | Crea una migración cuyo nombre es _NombreMigration_. |
| `php artisan make:seeder NombreSeeder` | Crea un seeder cuyo nombre es _NombreSeeder_. |
| `php artisan make:factory NombreFactory` | Crea una factoría cuyo nombre es _NombreFactory_. |
| `php artisan make:view NombreView` | Crea una vista cuyo nombre es _NombreView_. |
| `php artisan make:middleware NombreMiddleware` | Crea un middleware cuyo nombre es _NombreMiddleware_. |
| `php artisan tinker` | Abre una consola de PHP. |
| `php artisan migrate` | Ejecuta las migraciones de la base de datos. |
| `php artisan migrate:rollback` | Deshace la última migración de la base de datos. |
| `php artisan migrate:refresh` | Deshace todas las migraciones de la base de datos y vuelve a ejecutarlas. |
| `php artisan db:seed` | Ejecuta los seeders de la base de datos. |

## :warning: Acceso en desarrollo a la Plataforma de Debates RITSI

Para acceder a la Plataforma de Debates en una versión de desarrollo, puedes acceder con los siguientes datos:

* **Usuario administrador:** test@test.com
* **Usuario moderador:** moderator@moderator.com
* **Usuario normal:** user@user.com
* **Contraseña:** 1234

## :memo: Uso de la Plataforma de Debates RITSI

En esta sección detallo el uso de la Plataforma de Debates RITSI para los distintos tipos de usuarios.

### :cop: Usuario administrador

El usuario administrador es el usuario que tiene más privilegios en la Plataforma de Debates RITSI. Este usuario puede crear, editar y eliminar debates, usuarios, centros, socios, etc. 

[PDTE continuar documentación]

### :busts_in_silhouette: Usuario moderador

El usuario moderador es el usuario que tiene privilegios para moderar un debate. Esto quiere decir que podrá abrir, cerrar y gestionar los turnos de palabra de un debate.

[PDTE continuar documentación]

### :smiley: Usuario normal

El usuario normal es aquél que sólo puede solicitar turnos de palabra en un debate. Vamos, un asambleario normal y corriente.

Una vez que realizamos el login, nos aparecerá la siguiente pantalla:

<div style="text-align:center">
    <img src="./documentacion/captura_user_inicio.png" />
</div>

En esta pantalla, podemos ver los distitos _eventos_ que tenemos disponibles. En este caso, vamos a centrarnos en el evento de la _LVII AGO A Coruña_. Dentro del evento, podemos ver los distintos puntos del orden del día. Estos puntos se corresponden a los _debates_. En el desarrollo de una asamblea, entraremos al punto en el que estemos y podremos solicitar los turnos de palabra. En el caso de que estemos en un punto y pasemos al siguiente, el sistema nos cambiará automáticamente al debate del siguiente punto.

<div style="text-align:center">
    <img src="./documentacion/captura_user_debate.png" />
</div>

En la pantalla anterior, podemos ver uno de los debates que tuvieron lugar en aquella Asamblea. En la parte superior del cuerpo de la web nos aparece el título del debate, a la derecha tenemos una barra lateral con los _usuarios conectados_ y, en el centro, tenemos el cuerpo del debate.

El cuerpo del debate se diferencia por dos partes organizadas en dos columnas. En la columna izquierda, tenemos la lista de turnos de palabra que se han solicitado y, en la columna derecha, tenemos los turnos directos que se han solicitado. Ahora matizaré sobre el significado de cada uno de estos términos.

Tal y como podemos ver, en cada columna podemos _solicitar turno_ y, si tenemos un turno, _retirar turno_. También, nos encontramos con la coincidencia de que se quedó un turno de Nerea (compañera de Infra en el momento en el que os estoy redactando esto) abierto en la plataforma y nos sirve para poder saber como se ven los turnos.

En el caso de solicitar un turno directo, se vería tal que así:

<div style="text-align:center">
    <img src="./documentacion/captura_user_turnodirecto.png" />
</div>

#### Turnos de palabra

He comentado anteriormente que los turnos de palabra se dividen en dos tipos: _turnos_ y _turnos directos_. Los _turnos_ son los turnos de palabra que se solicitan en el debate, mientras que los _turnos directos_ son aquellos que se solicitan para debatir sobre aquello que está comentando el debatiente actual.

Es decir, suponiendo está Nerea hablando, si yo quiero hablar sobre lo que está diciendo Nerea, solicitaré un _turno directo_. Si, por el contrario, quiero hablar sobre otro tema, solicitaré un _turno_.

Y, hasta aquí la explicación y sentido de los turnos de palabra.


#### Navegación por la barra superior

En la barra superior nos podemos encontrar con los siguientes elementos:

* **Logo:** Este elemento nos lleva a la página principal de la plataforma.
* **Principal:** Este elemento nos lleva a la página principal de la plataforma.
* **_Nuestro nombre_:** Este elemento nos abre un desplegable con las siguientes opciones:
    * **Perfil:** Este elemento nos lleva a la página de nuestro perfil.
    * **Cerrar sesión:** Este elemento nos permite cerrar la sesión.
* **Contacto:** Este elemento nos lleva a la página de contacto.

<div style=text-align:center>
    <img src="./documentacion/captura_user_desplegable.png" />
</div>

#### Perfil

En la página de perfil, podemos ver los datos de nuestro perfil. En esta página, podemos editar nuestros datos y cambiar nuestra contraseña. Vamos a ver como se ve la página de perfil:

<div style=text-align:center>
    <img src="./documentacion/captura_user_profile.png" />
</div>

Hasta aquí, el uso de la Plataforma de Debates RITSI para los usuarios estándar.
