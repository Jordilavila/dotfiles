[![Free BSD](https://img.shields.io/badge/FreeBSD-B50000?style=for-the-badge&logo=freebsd&logoColor=white)](FreeBSD.md)

# RAID

Un _grupo o matriz redundante de discos independientes_ o RAID es un sistema de almacenamiento de datos que utiliza múltiples unidades, entre las que se distribuyen o se replican datos.

En función de su configuración (nivel) tendremos unos beneficios u otros, entre los que podemos encontrar: mayor integridad, tolerancia frente a fallos, tasa de transferencia y capacidad. Originalmente se buscaba combinar varios dispositivos de bajo coste y tecnología más vieja en un conjunto que ofrecía más capacidad, fiabilidad, velocidad o una combinación de éstas, para no usar un dispositivo de última generación y de mayor coste.

Los RAID más importantes que nos podemos encontrar son el RAID0, RAID1 y RAID5, entre muchos otros. Nosotros vamos a trabajar con el RAID5 y como simplemente vamos a demostrar su uso, vamos a crear cuatro discos duros de uno o dos gigabytes y montaremos el RAID con ellos.

Para combrobar que FreeBSD puede leer los discos, usaremos el comando ```ls /dev/ada*```.

## Construcción del RAID

Para activar el servicio del sistema RAID usaremos el siguiente comando:

```bash
service zfs enable  # Puede que esté habilitado por defecto
```

Tras esto tendremos que añadir en el archivo ```/boot/loader.conf``` estas líneas:

```bash
zfs_load="YES"      # Esta línea puede que ya esté por defecto
vfs_zfs_enable_prefetch_disable="1"
```

Ahora ya podemos crear nuestro RAID-5. Para esta tarea usaremos los siguientes comandos:

```bash
# Crear el RAID5
zpool create md0 raidz1 ada1 ada2 ada3 ada4

# Ver los RAID disponibles
zpool list

# Comprobar el estado del RAID
zpool status
```

Una vez creado, el RAID se monta automáticamente, pero por si necesitáramos montarlo, usaríamos el siguiente comando:

```bash
zfs mount
```

# Comprobando la integridad del RAID

No todo consiste en montar cosas y ya, también tenemos que comprobar su integridad, sobre todo con un RAID. Esto no es ni más ni menos que fastidiar un disco duro en caliente y volverlo a conectar.

```bash
# Romper el disco
zpool offline md0 /dev/ada3

# Comprobamos el estado y nos dirá: DEGRADED
zpool status

# Comprobamos que podemos leer el archivo que habíamos creado
cat /raid/elpepe.txt

# Volvemos a añadir el disco
zpool online md0 /dev/ada3

# Comprobamos de nuevo el estado del disco
zpool status
```
