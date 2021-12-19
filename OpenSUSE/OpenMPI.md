[![OpenSUSE](https://img.shields.io/badge/OpenSUSE-0C322C?style=for-the-badge&logo=SUSE&logoColor=white)](OpenSUSE.md)

# OpenMPI

OpenMPI es un conjunto de librerías que permiten la compilación y ejecución de software en paralelo a nivel de clúster, es decir, ejecutar un programa en varios ordenadores a la vez. 

Para instalar OpenMPI podemos hacer uso de los comandos que dejaré a continuación. Cabe destacar que luego añadiremos al PATH los binarios de OpenMPI y que tendremos que hacer una cosa u otra en función de la _shell_ que tengamos instalada. La _shell_ por defecto será _BASH_.

## Instalación de OpenMPI

Veamos la instalación de OpenMPI:

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
# En caso de estar trabajando con una terminal BASH (terminal por defecto)
echo export PATH="$PATH:/home/$USER/.openmpi/bin" >> /home/$USER/.bashrc
echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/" >> /home/$USER/.bashrc

# En caso de estar trabajando con una terminal ZSH
echo export PATH="$PATH:/home/$USER/.openmpi/bin" >> /home/$USER/.zshrc
echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/" >> /home/$USER/.zshrc
```
