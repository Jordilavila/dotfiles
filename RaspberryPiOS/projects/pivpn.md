![Raspberry Pi OS](https://img.shields.io/badge/Raspberry%20Pi%20OS-C51A4A?style=for-the-badge&logo=Raspberry-Pi)  
![OpenVPN](https://img.shields.io/badge/OpenVPN-1a3967?style=flat-square&logo=openvpn)

# PiVPN: Una VPN sencilla con nuestra Raspberry

https://kolwidi.com/blogs/blog-kolwidi/configura-pivpn-en-tu-raspberry-pi

https://www.raspipc.es/blog/creando-un-servidor-vpn-en-una-raspberry-pi/

https://github.com/pivpn/pivpn/issues/393

## Instalación de PiVPN

## Configuración de usuarios con PiVPN

Para añadir un usuario tendremos que usar el comando `pivpn add`. Tras instroducir este comando, el sistema nos pedirá un nombre de usuario para el _user_ que estamos creando y la duración (en días) del certificado que se crea. Además, también se pide la contraseña para el usuario.

Una vez creado el usuario, se generarán los certificados. El archivo que tendremos que enviar a la máquina que se conectará a la VPN es el _.ovpn_. 

### Cómo evitar el tráfico a Internet a través de la VPN

A veces, es necesario montar una VPN para mantener comunicación entre equipos que estén situados en lugares distintos y montar una especie de _sistema distribuído_. En este caso, nos interesará que el tráfico de red no esté vinculado a la VPN. Para ello, necesitaremos introducir unas líneas tras el siguiente fragmento del archivo OVPN:

```sh
auth SHA256
auth-nocache
verb 3
## Introducir aquí:
route-nopull                        # Esto indica que no se deben de modificar las tablas de rutas del cliente
route 10.8.0.0 255.255.0.0          # Esto es la ruta túnel por defecto de OpenVPN
route 192.168.0.0 255.255.255.0     # Esto es la red local del servidor OpenVPN
##
```

