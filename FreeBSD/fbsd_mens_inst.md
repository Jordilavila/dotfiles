![Free BSD](https://img.shields.io/badge/FreeBSD-B50000?style=for-the-badge&logo=freebsd&logoColor=white)

# Mensajería Instantánea (_OpenFire_)

Para instalar un servidor de mensajería instantánea podemos usar OpenFire.

La instalación de OpenFire se podrá llevar a cabo siguiendo estos comandos:

```bash
pkg install -y openfire
sysrc openfire_enable="YES"
service openfire restart
```

OpenFire se encuentra trabajando en el puerto 9090, por lo que tendremos que conectarnos desde el navegador de la propia máquina virtual a la dirección ```http://localhost:9090/setup/index.jsp```. Con esto entraremos a la configuración del servicio. Tras esto podremos acceder al servicio.

Como dato importante y a destacar: tenemos la opción de que OpenFire cree su propia base de datos automáticamente.

## Instalación del cliente (_Pidgin_)

Para instalar _Pidgin_ usaremos el siguiente comando:

```bash
pkg install -y pidgin pidgin-libnotify
``` 


