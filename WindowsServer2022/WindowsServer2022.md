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

Tras esto, ya tendremos Chocolatey instalado y funcionando. No nos vamos a quedar aquí, si en Linux hemos usado cosas tan básicas como ```nano```, estaría genial tenerlas también en Windows. Pues instalemos esas cositas que nunca vienen mal:

```powershell
# Run as admin
choco install nano grep
```

## Servicios remotos

Lo más normal es que usemos nuestro servidor de manera remota, por lo que usaremos algunos servicios remotos como ```SSH```, ```SFTP``` y ```SCP```.

Para instalar estos servicios tendremos que instalar ```SSH```, aunque ya nos lo encontramos instalado en nuestro sistema. Lo único que tenemos que hacer es habilitar la característica opcional del Servidor de OpenSSH. Esto lo tenemos en Configuración -> Aplicaciones y características -> Características opcionales.

Otra manera de instalarlo es usando Powershell. Vamos a verlo:

```powershell
# Instalación de OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server*

# Comprobar que está instalado
Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Ser*'
```

Finalmente, para comprobar que el servicio SSH funciona y por tal de repasar el funcionamiento de _SYSTEMD_ en Windows, podemos usar los siguientes comandos:

```powershell
# Comprobar el estado del servidor sshd
Get-Service sshd

# Iniciar el servidor sshd
Start-Service sshd

# Detener el servidor sshd
Stop-Service sshd
```

Es muy importante establecer como automático el arranque del servicio SSH para que se inicie con el sistema:

```powershell
# Establecer el arranque del servicio como automático
Set-Service sshd -StartupType Automatic
```

Para más detalles, es interesante revisar la [documentación de Microsoft](https://docs.microsoft.com/es-es/windows-server/administration/openssh/openssh_server_configuration).

### Asegurando que el firewall permite conexiones entrantes a través del puerto 22

El servicio SSH funciona por defecto a través del puerto 22, por lo que es conveniente comprobar que el firewall lo permite o activarlo en su defecto. Para ello será tan simple como escribir el siguiente comando:

```powershell
# Comprobando si existe alguna regla para el firewall
Get-NetFirewallRule -Name *OpenSSH-Server* |select Name, DisplayName, Description, Enabled

# Creación de una nueva regla para el firewall
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

### Configuración de SSH

Es necesario que por seguridad configuremos algunos aspectos de SSH para que se prohiban los accesos al usuario root y las contraseñas vacías. Para ello accederemos al archivo de configuración ```C:/ProgramData/ssh/sshd_config```. Como hemos instalado ```nano``` mediante Chocolatey, podemos editar el archivo con este programa. Descomentemos las líneas siguientes:

```powershell
# Abrir el archivo
nano C:/ProgramData/ssh/sshd_config
```

```powershell
PermitRootLogin no
PermitEmptyPasswords no
```

Ahora debemos reiniciar el servicio:

```powershell
Restart-Service sshd
```

### Activando el log de SSH

Para activar el log de SSH tendremos que acceder al ```C:/ProgramData/ssh/sshd_config``` y modificar las líneas siguietnes para qeu queden tal que así:

```powershell
#Logging
SyslogFacility DAEMON
LogLevel DEBUG
```

Ahora debemos de reiniciar el servicio:

```powershell 
Restart-Service sshd
```

### Generando una contraseña en un cliente para acceder al servidor

Para general clas claves pñublicas y privadas debemos hacer lo siguiente:

```powershell
## EJECUTAR POWERSHELL EN MODO DE ADMINISTRADOR

# Generar claves pública y privada en el directorio /home/root/.ssd
ssh-keygen -t rsa

# Acceder al directorio donde están las claves:
cd /root/.ssh

# Enviar al ordenador destino las claves para que se conecte sin pedirle la contraseña.
ssh-copy-id -i id_rsa.pub SERVER_USERNAME@SERVER_IP
```

### Funcionamiento de SFTP

Este servicio viene con SSH, por lo que no hay que instalar nada. Sólo tenemos que saber como usarlo.

Para conectarnos por Secure File Transfer Protocol usaremos el siguiente comando:

```bash
sftp REMOTE_USER@REMOTE_IP
```

### Funcionamiento de SCP

Este servicio también viene con SSH, por lo tanto, no tendremos que instalar nada.

Para conectarnos por SCP usaremos el siguiente comando:

```bash
scp <-P <puerto>> <ruta de archivo local> REMOTE_USER@REMOTE_IP:<ruta destino>
```

