[![Windows Server](https://img.shields.io/badge/Windows%20Server-0078D6?style=for-the-badge&logo=windows&logoColor=white)](WindowsServer2022.md)

# RAID

Un _grupo o matriz redundante de discos independientes_ o RAID es un sistema de almacenamiento de datos que utiliza múltiples unidades, entre las que se distribuyen o se replican datos.

En función de su configuración (nivel) tendremos unos beneficios u otros, entre los que podemos encontrar: mayor integridad, tolerancia frente a fallos, tasa de transferencia y capacidad. Originalmente se buscaba combinar varios dispositivos de bajo coste y tecnología más vieja en un conjunto que ofrecía más capacidad, fiabilidad, velocidad o una combinación de éstas, para no usar un dispositivo de última generación y de mayor coste.

Los RAID más importantes que nos podemos encontrar son el RAID0, RAID1 y RAID5, entre muchos otros. Nosotros vamos a trabajar con el RAID5 y como simplemente vamos a demostrar su uso, vamos a crear cuatro discos duros de uno o dos gigabytes y montaremos el RAID con ellos.

## Construcción del RAID

Para montar un sistema RAID en Windows tendremos que acceder a la aplicación de _administrador de discos_ y seleccionaremos aquellos con los que queremos montar el sistema RAID.

Nada más abrir la aplicación nos pedirá que inicialicemos los discos. Lo haremos con una tabla de particiones GPT. Tras esto nos aparecerán cuatro discos duros exactamente iguales. Acto seguido haremos click sobre el menú de _Acción_ y abriremos el desplegable de _Todas las tareas_ y, finalmente, seleccionaremos _Nuevo volumen RAID-5_. Esto nos abrirá una nueva ventana para configurar el sistema RAID5.

Seguiremos las instrucciones que nos brinda Windows y añadiremos los cuatro discos duros. A continuación, todo será continuar con las instrucciones y Windows se encargará de todo.

![RAID 5](images/ws_raid5_formateando.md)

Cuando Windows acabe de formatear los discos duros del RAID tendremos pleno acceso a ellos y podremos trabajar sin problemas.

## Comprobando la integridad del RAID

Para comprobar si el RAID tiene errores y repararlos, iremos a las propiedades del disco, desde el mismo explorador, y cambiaremos a la pesataña de _herramientas_, donde usaremos la app de _Comprobación de errores_.

Por otra parte, en el _Administrador de discos_ podemos hacer click sobre algún disco y tendremos la opción de _Sin conexión_. Esta opción provocará un error en el RAID. Tras esto, lo volvemos a conectar y le decimos que reactive el disco. Automáticamente se volverán a sincronizar y tendremos hecha la prueba de integridad.

