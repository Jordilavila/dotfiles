![Windows 11](https://img.shields.io/badge/Windows%2011-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)

# Windows 11

Windows 11 va a ser el sistema operativo por excelencia para muchos usuarios y uno de los que más voy a usar en mi carrera universitaria y máster. Por ello, en esta sección recojo unas cositas esenciales para el sistema de escritorio de Microsoft.

## Cosas interesantes para instalar

- [Chocolatey](Chocolatey.md)
- [Laravel](Laravel.md)
- [MariaDB (MySQL)](MariaDB.md)

## Carpeta del GodMode

Esto es una funcionalidad oculta de Windows en la que podemos crear una carpeta que recoja algunas funcionalidades del sistema. Ni aporta ni quita, pero es interesante para dejar a cuadros a los colegas. Para que funcione, creamos una carpeta en el escritorio con el nombre de ```GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}.```.

## Puesta a punto de WSL

A veces necesitamos usar Linux y no podemos tener montado el dual boot por espacio o por cualquier otra cosa. Tenemos una solución: usemos WSL (Windows Subsystem for Linux) e instalemos un sistema Linux como OpenSUSE.

### Pasos previos

El primer paso previo a la instalación de la WSL será comprobar que tenemos habilitada la virtualización. Para ello, abrimos el administrador de tareas, entramos a la sección de rendimiento y la pestalla de CPU nos aparecerá si la virtualización está activa o no.

En caso de no estar activa, tendremos que acceder a la BIOS y activar dicha función.

Una vez activada la virtualización, introduciremos el siguiente comando:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

O bien, podemos acceder a _características de windows_ y activar:

- Plataforma de virtualización de Windows
- Plataforma del hipervidsor de Windows
- Subsistema de Windows para Linux

Finalmente, reiniciamos el sistema.

### Instalación de WSL

Para instalar WSL tendremos que abrir una powershell en modo de administrador e introducir la siguiente batería de comandos:

```powershell
# Listar las distribuciones disponibles:
wsl -l -o

# Instalar OpenSUSE Leap:
wsl --install -d openSUSE-42
```

Otra opción que tenemos y la que **yo recomiendo** es entrar a la Tienda de Windows y bajarnos OpenSUSE Tumbleweed, ya que es el sistema que estoy usando en mi máquina principal y el que recibe las últimas actualizaciones.

Finalmente, podemos comprobar nuestro sistema y la versión de WSL en la que está usando este comando:

```powershell
wsl --list -v
```

Este comando, al darnos el nombre del sistema que hemos instalado, nos brinda el modo de arrancarlo desde Powershell, que será tan sencillo como escribir lo siguiente en la Powershell:

```powershell
openSUSE-Tumbleweed
```

### Programas necesarios corriendo en el Linux

En mi caso, un perfil desarrollador, será necesario tener instalada la paquetería necesaria para compilar programas, al menos, en C. Para ello, instalaré lo siguiente:

```bash
sudo zypper install gcc valgrind make gdb gcc-c++
```

Si queremos más información sobre OpenSUSE, podemos acceder a [ésta](../OpenSUSE/OpenSUSE.md) parte del repositorio.

### SystemD

Los que estamos más familiarizados con el uso de sistemas Linux utilizamos a menudo el comando `systemctl`. Esto no está activado por defecto en las máquinas de la WSL, por lo que recomiendo bastante activarlo. Para ello entraremos en la máquina WSL y ejecutaremos el siguiente comando:

```bash
sudo nano /etc/wsl.conf
```

Se nos abrirá un fichero de configuración de la WSL y tendremos que añadir el siguiente fragmento:

```bash
[boot]
systemd=true
```

Tras esto, salimos de la máquina virtual y ejecutamos el siguiente comando en la PowerShell:

```powershell
wsl.exe --shutdown
```

Esto reiniciará la máquina virtual y activará `systemd`.
