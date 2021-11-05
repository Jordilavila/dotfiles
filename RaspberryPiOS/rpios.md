![Raspberry Pi OS](https://img.shields.io/badge/Raspberry%20Pi%20OS-C51A4A?style=for-the-badge&logo=Raspberry-Pi)  
![Raspberry Pi](https://img.shields.io/badge/Raspberry%20Pi-C51A4A?style=flat-square&logo=Raspberry-Pi)

# Raspberry Pi OS

El sistema operativo oficial de la Raspberry Pi se llama Raspberry Pi OS y no es más que un Debian ARM modificado para ser lo más optimo posible en esta placa. También hay versiones instalables en cualquier PC o Mac, pero eso no me interesa.

En esta sección del repositorio pretendo recopilar toda la información posible sobre conceptos que considero importantes a guardar sobre la Raspberry.

Puesto que llegados a este punto se supone que ya tenemos el sistema instalado y sabemos como funcionan Debian y Ubuntu, no hay más que ejecutar una _full-upgrade_ de nuestro sistema:

```bash
sudo apt full-upgrade
```

Es necesario que activemos el servidor SSHD de la Raspberry para poder usarla de manera remota, ya que no tiene mucho sentido tener una Raspberry funcionando como servidor y que tenga una interfaz gráfica corriendo. Por lo tanto, para acceder a ella, usaremos SSH. Esto se puede hacer con el comando ```raspi-config```.

Proyectos que he hecho con la Raspberry Pi:

- [PiVPN](projects/pivpn.md): Una VPN sencilla con nuestra Raspberry
