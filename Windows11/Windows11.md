![Windows 11](https://img.shields.io/badge/Windows%2011-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)

# Windows 11

Windows 11 va a ser el sistema operativo por excelencia para muchos usuarios y uno de los que más voy a usar en mi carrera universitaria y máster. Por ello, en esta sección recojo unas cositas esenciales para el sistema de escritorio de Microsoft.

## Instalación de Chocolatey

En Windows 11 no tenemos en estos momentos (Noviembre de 2021) un gestor de paquetería funcional, _winget_ no está terminado, aunque funciona. Esto nos trae la necesidad de instalar Chocolatey.
Para ello, abrimos Powershell en modo administrador y escribimos lo siguiente:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Tras esto, ya tendremos Chocolatey instalado y funcionando. No nos vamos a quedar aquí, si en Linux hemos usado cosas tan básicas como ```nano```, estaría genial tenerlas también en Windows. Pues instalemos esas cositas que nunca vienen mal:

```powershell
# Run as admin
choco install nano grep
```

## Carpeta del GodMode

Esto es una funcionalidad oculta de Windows en la que podemos crear una carpeta que recoja algunas funcionalidades del sistema. Ni aporta ni quita, pero es interesante para dejar a cuadros a los colegas. Para que funcione, creamos una carpeta en el escritorio con el nombre de ```GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}.```.

## Activando WSL2 e instalando un Linux en WSL

A veces necesitamos usar Linux y no podemos tener montado el dual boot por espacio o por cualquier otra cosa. Tenemos una solución: usemos WSL (Windows Subsystem for Linux) e instalemos un sistema Linux como OpenSUSE.

