# Instalación de Chocolatey

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