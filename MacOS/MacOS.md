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

## Una capa de personalización

Por añadirle una capa de personalización al Mac, he añadido un fondo de pantalla. 

![Cyberpunk Wallpaper](../images/wallpapers/cyberpunk_samurai_sword_girl_2k.jpg)

Nos lo podemos descargar desde [aquí](../images/wallpapers/cyberpunk_samurai_sword_girl_2k.jpg)

## Personalizando la terminal

Al igual que en los sistemas Linux, también podemos personalizar la terminal de nuestro Mac. Cabe destacar que en los MacOS recientes la terminal por defecto es ZSH, por lo que esto va a ser muy sencillo de llevar a cabo.

El primer paso consiste en instalar las fuentes nuevas para la terminal, con lo que podremos ver todos los iconos y demás:

```zsh
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

Tras instalar esto, tenemos que acceder a las preferencias de la consola y en el apartado de la fuente de texto, escoger la fuente _Hack Regular Nerd_. Esta se actualizará automáticamente. Tras esto vamos a instalar Oh-My-Zsh con el siguiente comando:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Ahora descargamos _powerlevel10k_:

```zsh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

Ahora vamos a buscar en el archivo de configuración (```.zshrc```) la opción de elegir el tema y lo dejaremos tal que así:

```zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Tras esto, reiniciamos la terminal y entraremos la configuración. A mi me gusta una configuración basada en [esta](https://www.swtestacademy.com/customize-mac-terminal/) pero con dos líneas. 

Finalmente, tendremos nuestra consola bien configurada.


