[![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)](RockyLinux.md)

# Servidor de impresión PDF con CUPS

Vamos a configurar un servidor de impresión usando CUPS para que nos imprima un archivo en formato PDF. Para ello vamos a tener que instalar un conjunto de paquetes y configurar y activar servicios. Todo esto vamos a poder hacerlo ejecutando un [script](install_files/install_cups.sh) que he escrito.

## Instalación de CUPS

Para instalar y habilitar CUPS podemos ejecutar el script o escribirlo a mano. Si queremos ejecutar el script debemos hacer lo siguiente:

```bash
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/RockyLinux/install_files/install_cups.sh
sh install_cups.sh
```

Por otra parte, si lo preferimos hacerlo a mano:

```bash
dnf install -y cups hplip gutenprint-cups cups-pdf
systemctl enable cups
systemctl start cups
```

Instalación de CUPS-PDF

```bash
wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/c/cups-pdf-2.6.1-7.el7.x86_64.rpm
dnf install -y cups-pdf-2.6.1-7.el7.x86-64.rpm
rm -f cups-pdf-2.6.1-7.el7.x86-64.rpm
```

Finalmente, comprobamos que el servicio está corriendo en nuestra máquina:

```bash
systemctl status cups
```

## Configuración de CUPS

CUPS se encuentra configurado por defecto para uso local, por lo tanto, vamos a configurarlo para que pueda funcionar en la red LAN. Para configurar CUPS tendremos que acceder al archivo de configuración que encontramos en ```/etc/cups/cupsd.conf```.

Lo primero que vamos a hacer será cambiar la línea siguiente:

```bash
### Línea original
Listen localhost:631

### Lína que necesitamos
Port 631
```

Ahora tendremos que compartir las impresoras en la red local:

```bash
### Bloque original:
# Show shared printers on the local network.
Browsing On
BrowseLocalProtocols dnssd

# Default authentication type, when authentication is required...
DefaultAuthType Basic

### Bloque a establecer:
# Show shared printers on the local network.
Browsing On
BrowseOrder allow,deny
BrowseLocalProtocols dnssd
#BrowseAllow @LOCAL
BrowseAllow 192.168.137.* # change to local LAN settings
BrowseAddress 192.168.137.* # change to local LAN settings

# Default authentication type, when authentication is required...
DefaultAuthType Basic
```

Finalmente, configuramos el servicio para que se pueda acceder a él en toda la red local:

```bash
### Bloque original:
# Restrict access to the server...
<Location />
  Order allow,deny
</Location>

# Restrict access to the admin pages...
<Location /admin>
  Order allow,deny
</Location>

# Restrict access to configuration files...
<Location /admin/conf>
  AuthType Default
  Require user @SYSTEM
  Order allow,deny
</Location>

### Bloque a escribir:
# Allow access to the server from any machine on the LAN
<Location />
  Order allow,deny
  Allow 192.168.137.* # change to local LAN settings
</Location>

# Allow access to the admin pages from any machine on the LAN
<Location /admin>
  #Encryption Required
  Order allow,deny
  Allow 192.168.137.* # change to local LAN settings
</Location>

# Allow access to configuration files from any machine on the LAN
<Location /admin/conf>
  AuthType Basic
  Require user @SYSTEM
  Order allow,deny
  Allow 192.168.137.* # change to local LAN settings
</Location>
```

Si tenemos clientes Windows en la red, será interesante modificiar los archivos ```/usr/share/cups/mime/mime.types``` y ```/usr/share/cups/mime/mime.convs``` para añadir la siguiente línea:

```bash
application/octet-stream
```

## Activando el log de CUPS

En el caso de querer activar el log de CUPS tendremos que acceder al archivo ```usr/local/etc/cups/cupsd.conf``` y cambiar la línea siguiente:

```bash
### Línea original:
LogLevel warn

### Línea a establecer:
LogLevel debug
```

## Permitiendo la conexión a través del Firewall

Para permitir las conexiones a la impresora a través del Firewall tendremos que introducir los siguietnes comandos:

```bash
firewall-cmd --permanent --add-port=631/tcp
systemctl reload firewalld
```

También tendremos que activar este servicio:

```bash
systemctl enable cups-browsed
systemctl start cups-browsed
```