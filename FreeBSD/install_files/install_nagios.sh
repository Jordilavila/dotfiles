########################################
### INSTALACION DE NAGIOS EN FREEBSD ###
########################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

pkg install apache24 mod_php74 php74-gd php-74-mysqli php74 mariadb105-server
service apache24 enable
service apache24 restart
service mysql-server enable
service mysql-server restart

cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
rehash

pkg install -y nagios4

cd /usr/local/etc/nagios
cp cgi.cfg-sample cgi.cfg
cp nagios.cfg-sample nagios.cfg
cp resource.cfg-sample resource.cfg
cd objects
cp commands.cfg-sample commands.cfg
cp contacts.cfg-sample contacts.cfg
cp localhost.cfg-sample localhost.cfg
cp printer.cfg-sample printer.cfg
cp switch.cfg-sample switch.cfg
cp templates.cfg-sample templates.cfg
cp timeperiods.cfg-sample timeperiods.cfg
chmod -R 777 /usr/local/etc/nagios


