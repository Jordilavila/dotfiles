![Windows Server](https://img.shields.io/badge/Windows%20Server-0078D6?style=for-the-badge&logo=windows&logoColor=white)

# Windows Server 2022

Windows Server 2022 es un sistema Windows dedicado a servidores. Yo lo he tenido que usar para alguna asignatura de la carrera.

## Después de la instalación

Algunas cosas importantes tras instalar Windows Server.

### Actualización del sistema

No es de extrañar que lo primero que tengamos que hacer tras instalar un sistema sea obtener las últimas actualizaciones. Para ello nos vamos a Windows Update y actualizamos el sistema.

### Si estamos en VirtualBox

Si trabajamos con VirtualBox necesitaremos instalar las GuestAdditions. Esto se hace introduciendo el CD de las GuestAdditions y arrancando el instalador.

### Puesta a punto de las redes

Como en todos los sistemas Windows, para poner las redes a punto tendremos que acceder al _Centro de Redes y Recursos Compartidos_, que actualmente es una opción del sistema a la que podemos acceder con la barra de búsqueda de aplicaciones del menú inicio. Escribiendo _ver conexiones de red_ entraremos en la aplicación.

Una vez dentro, click derecho sobre la red que queramos modificar, click sobre propiedades y buscamos IPv4. Ahora clickaremos sobre propiedades y podremos modificar la IP y el DNS.

### Instalación de Chocolatey

En Windows Server no tenemos un gestor de paquetería instalado, _winget_ no está activo por ahora. Esto nos trae la necesidad de instalar Chocolatey.
Para ello, abrimos Powershell en modo administrador y escribimos lo siguiente:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Tras esto, ya tendremos Chocolatey instalado y funcionando.

## Servicios remotos

Lo más normal es que usemos nuestro servidor de manera remota, por lo que usaremos algunos servicios remotos como ```SSH```, ```SFTP``` y ```SCP```.

Para instalar estos servicios tendremos que instalar ```SSH```, aunque ya nos lo encontramos instalado en nuestro sistema.

### Configuración de SSH

Es necesario que por seguridad configuremos algunos aspectos de SSH para que se prohiban los accesos al usuario root y las contraseñas vacías. 
```