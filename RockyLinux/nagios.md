[![Rocky Linux](https://img.shields.io/badge/Rocky%20Linux-35BF5C?style=for-the-badge&logo=redhat&logoColor=white)](RockyLinux.md)

# NAGIOS

Nagios es un sistema de monitorización de redes que vigila los equipos y los servicios que se especifiquen, alertando cuando el comportamiento de los mismos no sea el deseado. Entre sus características principales figuran la monitorización de servicios de red, la monitorización de los recursos de sistemas hardware (carga de la cpu, uso de discos, etc.), independencia de sistemas operativos, etc.

Este software es bastante versátil para consultar prácticamente cualquier parámetro de interés de un sistema, y genera alertas que se pueden recibir por email y SMS. Otro dato interesante es que se consulta en una web en PHP que montamos en el servidor.

Entonces, el primer paso será montar nuestro servidor Apache con las funcionalidades de PHP y una base de datos de MariaDB.


