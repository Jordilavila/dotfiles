# Plataforma de Debates RITSI

## ¿Qué es?

La _Plataforma de Debates RITSI_ es una herramienta desarrollada por los miembros de RITSI para facilitar la organización y moderación de los debates que tengan lugar en la Asamblea General de RITSI. Esta plataforma está desarrollada en Laravel y se encuentra alojada en un servidor de RITSI.

## ¿Cómo funciona?

La plataforma se divide en dos partes: la parte pública y la parte privada. La parte pública es la que se encuentra en [este enlace](https://debates.ritsi.es). Consta de un _login_ y un botón de _contacto_.

La sección privada es a la que accederemos con nuestra cuenta de usuario. En ella podremos acceder a los eventos que tengamos creados y, en ellos, al debate en cuestión. En el debate podremos solicitar _turnos de palabra_ y _turnos directos_. También podremos ver los _turnos de palabra_ y _turnos directos_ que ya han sido concedidos, así como el listado de usuarios conectados.

## ¿Qué necesito para programar mejoras de la plataforma?

Para programar mejoras de la plataforma necesitarás tener conocimientos de Laravel y de PHP. También necesitarás tener acceso a un servidor con PHP 7.4 y MySQL 5.7. Puedes utilizar una máquina virtual, la WSL o tu máquina local. Si no tienes conocimientos de Laravel, puedes consultar la [documentación oficial](https://laravel.com/docs/5.4/homestead). Si no tienes conocimientos de PHP, puedes consultar la [documentación oficial](https://www.php.net/manual/es/intro-whatis.php). Si no tienes conocimientos de MySQL, puedes consultar la [documentación oficial](https://dev.mysql.com/doc/refman/8.0/en/).

Para instalar Laravel en tu sistema tendrás que seguir los siguientes pasos:

### Windows

1. Instala [Composer](https://getcomposer.org/download/).
2. Instala [Git](https://git-scm.com/downloads).
3. Instala [VSCode](https://code.visualstudio.com/download).
4. Instala [MySQL](https://dev.mysql.com/downloads/installer/).
5. Instala [PHP 7.4](https://windows.php.net/download#php-7.4).
6. Instala [Laravel](https://laravel.com/docs/5.4/homestead#installing-laravel).

### Linux

1. Instala [Git](https://git-scm.com/downloads).
2. Instala [VSCode](https://code.visualstudio.com/download).
3. Instala [MySQL](https://dev.mysql.com/downloads/installer/).
4. Instala [PHP 7.4](https://windows.php.net/download#php-7.4).
5. Instala [Laravel](https://laravel.com/docs/5.4/homestead#installing-laravel).

### Mac

1. Instala [Brew](https://brew.sh/index_es).
2. Instala [VSCode](https://code.visualstudio.com/download).
3. Instala [MySQL](https://dev.mysql.com/downloads/installer/).
4. Instala [PHP 7.4](https://windows.php.net/download#php-7.4).
5. Instala [Laravel](https://laravel.com/docs/5.4/homestead#installing-laravel).

### Importante para Laravel

Para que Laravel funcione correctamente, necesitarás tener instaladas las siguientes extensiones de PHP:

*   OpenSSL PHP Extension
*   PDO PHP Extension
*   Mbstring PHP Extension
*   Tokenizer PHP Extension
*   XML PHP Extension
*   Ctype PHP Extension
*   JSON PHP Extension
*   MySQL PHP Extension

## Comandos básicos de Laravel

Aquí tienes una lista de comandos básicos de Laravel:

*   `php artisan serve` - Inicia el servidor de desarrollo de Laravel.
*   `php artisan migrate` - Ejecuta las migraciones de la base de datos.
*   `php artisan migrate:fresh` - Limpia las migraciones de la base de datos.
*   `php artisan migrate:refresh` - Limpia las migraciones de la base de datos y las vuelve a ejecutar.
*   `php artisan migrate:rollback` - Revierte la última migración de la base de datos.
*   `php db:seed` - Ejecuta los seeders de la base de datos.
*   `php artisan tinker` - Inicia la consola de Laravel.
*   `php artisan make:controller` - Crea un controlador.
*   `php artisan make:model` - Crea un modelo.
*   `php artisan make:seeder` - Crea un seeder.
*   `php artisan make:migration` - Crea una migración.
*   `php artisan make:factory` - Crea una factoría.
*   `php artisan make:view` - Crea una vista.
*   `php artisan make:middleware` - Crea un middleware.

