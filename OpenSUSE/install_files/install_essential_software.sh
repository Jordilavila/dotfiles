####################################################
### INSTALACION DE SOFTWARE ESENCIAL EN OPENSUSE ###
####################################################

## REQUISITOS:
# Conexión a Internet activa.
# Correr el script como usuario root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

## Refresh and update:
zypper refresh && zypper update -y

## Essential Software:
zypper install -y git gcc gdb valgrind make
zypper install -y vlc qbittorrent

## Visual Studio Code:
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
zypper refresh
zypper install -y code

## GitKraken:
wget https://release.gitkraken.com/linux/gitkraken-amd64.rpm
zypper install -y gitkraken-amd64.rpm
rm -f gitkraken-amd64.rpm