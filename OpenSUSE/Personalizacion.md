[![OpenSUSE](https://img.shields.io/badge/OpenSUSE-0C322C?style=for-the-badge&logo=SUSE&logoColor=white)](OpenSUSE.md)

# Personalizando OpenSUSE

La versión por defecto de OpenSUSE se queda bastante pobre, por lo que es interesante darle una capa de personalización para hacerlo más a nuestro gusto.

Para ello vamos a ver unas GNOME Extensions y el cambio de BASH a ZSH.

## Mis GNOME Extensions favoritas

Prefiero usar el escritorio de GNOME porque con KDE el uso de múltiples pantallas es bastante penoso. Espero que cuando Wayland esté a pleno funcionamiento la cosa cambie, pero creo que me quedaré con GNOME. Este entorno gráfico tiene un aire muy parecido a Mac y eso me gusta bastante. Así mismo, al GNOME base que incluye OpenSUSE creo que le hacen falta unos complementos, a mi parecer bastante útiles, como los siguientes:

- Un menú de aplicaciones completo, desplegable desde la barra de arriba. El que yo instalo es [ArcMenu](https://extensions.gnome.org/extension/3628/arcmenu/) y, además, se le puede cambiar el icono. Un puntazo.
- Un controlador del dock que verdaderamente brinde una experiencia a lo Mac. El que yo uso es [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/).
- Un controlador de la velocidad de nuestra conexión a Internet. Yo uso [NetSpeed](https://extensions.gnome.org/extension/104/netspeed/).
- Un indicador y controlador del espacio de trabajo. Me parece interesante [Workspace indicator](https://extensions.gnome.org/extension/3952/workspace-indicator/)

## Adiós BASH, hola ZSH

Esto es bastante irrelevante pero, como usé ZSH en Manjaro y me gustó tanto, ahora también la quiero en OpenSUSE. Esto no es nada más que instalar un intérprete de Shell distinto. Para instalarlo usaremos el siguiente conjunto de comandos:

```bash
sudo zypper install zsh
```

Ahora tocaría cambiar al nuevo Shell y configurarlo, para ello basta con hacer esto y leer y seguir los pasos:

```bash
zsh
```

Una vez configurado tendremos que cambiar el shell por defecto, y para ello usaremos este comando y seguiremos los pasos que nos pidan:

```bash
# Listado de shells:
cat /etc/shells

# Cambiar el shell por defecto:
chsh
```

Finalmente, reiniciamos el sistema y veremos los cambios. No son muy estéticos, la verdad. Ahora nos tocará instalar _Oh my Shell!_:

```bash
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

Finalmente, para escoger un tema (a mi me gusta _agnoster_) entraremos al archivo de configuración de ZSH mediante el comando ```sudo nano .zshrc
