#!/bin/bash

vColorRojo='\033[1;31m'
vColorVerde='\033[1;32m'
vFinColor='\033[0m'

vFechaDeEjecCopSeg=$(date +A%Y-M%m-D%d@%T)

vUsuario="nipegun"
vCarpetaBD="/home/$vUsuario/.chia/mainnet/db/"

echo ""
echo -e "${vColorVerde}  Iniciando la copia de seguridad de la base de datos del nodo Chia...${vFinColor}"
echo ""

mkdir -p /CopSegInt/XCH/CopSegBD/$vFechaDeEjecCopSeg 2> /dev/null

# Comprobar si el paquete rsync está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s rsync 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "  rsync no está instalado. Iniciando su instalación..."
    echo ""
    apt-get -y update
    apt-get -y install rsync
    echo ""
  fi
rsync -av $vCarpetaBD /CopSegInt/XCH/CopSegBD/$vFechaDeEjecCopSeg
