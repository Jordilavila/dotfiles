![OpenSUSE](https://img.shields.io/badge/OpenSUSE-0C322C?style=for-the-badge&logo=SUSE&logoColor=white)

# Herramientas esenciales para C++

Entre las herramientas esenciales para trabajar con C++ destacan los compiladores y algunas herramientas para la memoria.

Para instalar las herramientas eseciales usaremos el siguiente comando:

```bash
sudo zypper refresh && sudo zypper update -y
sudo zypper install -y git gcc gdb valgrind make cmake
```

## Instalación de VSCode

Para instalar VSCode haremos lo siguiente:

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install -y code
```

## Instalación de GitKraken

Para instalar GitKraken haremos lo siguiente:

```bash
wget https://release.gitkraken.com/linux/gitkraken-amd64.rpm
sudo zypper install -y gitkraken-amd64.rpm
sudo rm -f gitkraken-amd64.rpm
```

## Instalación de OpenMP y OpenCV

La instalación de estas herramientas se instalará tal que así:

´´´bash
sudo zypper install -y opencv openmp-devel
´´´
