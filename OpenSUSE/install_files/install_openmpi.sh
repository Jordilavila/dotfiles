##########################################
### INSTALACION DE OPENMPI EN OPENSUSE ###
##########################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.2.tar.gz -O openmpi.tar.gz
tar -xvf openmpi
cd openmpi
./configure --prefix="/home/$USER/.openmpi"
make
sudo make install
export PATH="$PATH:/home/$USER/.openmpi/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"
echo export PATH="$PATH:/home/$USER/.openmpi/bin" >> /home/$USER/.bashrc
echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/" >> /home/$USER/.bashrc
