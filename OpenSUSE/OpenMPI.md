
# OpenMPI

OpenMPI es un conjunto de librerías que permiten la compilación y ejecución de software en paralelo a nivel de clúster, es decir, ejecutar un programa en varios ordenadores a la vez. 

Para instalar OpenMPI podemos hacer uso de un script que he preparado o usar los comandos que dejaré a continuación. Cabe destacar que luego añadiremos al PATH los binarios de OpenMPI y que tendremos que hacer una cosa u otra en función de la _shell_ que tengamos instalada. La _shell_ por defecto será _BASH_.

## Instalación de OpenMPI

Veamos la instalación de OpenMPI:

### Instalación mediante el script:

Para instalar OpenMPI mediante el script que he preparado, haremos uso de los siguientes comandos:

```bash
wget https://raw.githubusercontent.com/Jordilavila/dotfiles/main/OpenSUSE/install_files/install_openmpi.sh
sudo sh install_openmpi.sh
```

### Instalación mediante comandos:

Para instalar OpenMPI mediante comandos, usaremos los siguientes:

```bash
wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.2.tar.gz -O openmpi.tar.gz
tar -xvf openmpi.tar.gz
cd openmpi-4.1.2
./configure --prefix="/home/$USER/.openmpi"
make
sudo make install
export PATH="$PATH:/home/$USER/.openmpi/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"
```

### Añadiéndolo al PATH

En caso de que queramos añadir estas nuevas variables al PATH del sistema en las siguientes sesiones, usaremos los siguientes comandos:

```bash
# En caso de estar trabajando con una terminal BASH (el script lo hace por defecto)
echo export PATH="$PATH:/home/$USER/.openmpi/bin" >> /home/$USER/.bashrc
echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/" >> /home/$USER/.bashrc

# En caso de estar trabajando con una terminal ZSH (no pasa nada por usar esto si hemos usado el script)
echo export PATH="$PATH:/home/$USER/.openmpi/bin" >> /home/$USER/.zshrc
echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/" >> /home/$USER/.zshrc
```
