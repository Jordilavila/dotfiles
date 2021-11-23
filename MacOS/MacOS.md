![Mac OS](https://img.shields.io/badge/Mac%20OS-000000?style=for-the-badge&logo=apple&logoColor=F0F0F0)

# Mac OS

Como usuario de Mac tampoco podía faltar esta sección en el repositorio, puesto que no me gusta ir buscando las cosas y me gusta tenerlas recogidas. 

¿Por qué Mac OS? Música, nuevos horizontes y comodidad. Música por todo lo que brinda el sistema de la manzana (hoy en día es algo más insignificativo). Nuevos horizontes por querer investigar sobre el ecosistema Apple, que me gusta bastante. Comodidad por la universidad, tener una buena batería es primordial si no hay enchufes y llevar poco peso encima también.

## Instalando el software esencial

MacOS no tiene un gestor de paquetería como el que nos podemos encontrar en los sistemas Debian o RHEL, por ejemplo. Por lo que, como buenos _devs_ lo suyo es tener uno, concretamente _brew_ (sí, cervecero). Pero para ello, necesitaremos instalar previamente **XCode** desde la tienda de aplicaciones de Apple.

Una vez instalado XCode, podremos instalar _brew_ con el siguiente comando:

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Tras una espera meridianamente larga, en función de la velocidad de nuestra conexión a Internet, tendremos _brew_ en nuestro sistema Mac. Ahora podemos instalar los paquetes que nos puedan parecer útiles usando este comando:

```zsh
brew install wget neofetch lolcat
```
