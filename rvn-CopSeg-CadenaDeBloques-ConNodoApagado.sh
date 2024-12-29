#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para hacer copia de seguridad de la cadena de bloques de raven con el nodo apagado
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/main/rvn-CopSeg-CadenaDeBloques-ConNodoApagado.sh | bash
#   curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/main/rvn-CopSeg-CadenaDeBloques-ConNodoApagado.sh | sed 's-vCarpetaCopSeg="/CopSegInt"-vCarpetaCopSeg="/Copia"-g' | bash
# ----------

# Definir variables de color
  vColorAzul="\033[0;34m"
  vColorAzulClaro="\033[1;34m"
  vColorVerde='\033[1;32m'
  vColorRojo='\033[1;31m'
  vFinColor='\033[0m'

vFechaDeEjecCopSeg=$(date +A%Y-M%m-D%d@%T)
vCarpetaCopSeg="/CopSegInt"

# Definir la carpeta de usuario
  # Ver si la variable de entorno HOME termina con una /
     vCarpetaUsuario="$HOME"
     if [[ "$vCarpetaUsuario" == */ ]]; then
       # Quitarle la /
       vCarpetaUsuario=${vCarpetaUsuario%?}
     fi

CarpetaBD1="$vCarpetaUsuario/.raven/blocks/"
CarpetaBD2="$vCarpetaUsuario/.raven/chainstate/"

echo ""
echo -e "${ColorVerde}  Iniciando la copia de seguridad de la base de datos del nodo Raven...${FinColor}"
echo ""

mkdir -p $vCarpetaCopSeg/RVN/CopSegBD/$vFechaDeEjecCopSeg/blocks/ 2> /dev/null
mkdir -p $vCarpetaCopSeg/RVN/CopSegBD/$vFechaDeEjecCopSeg/chainstate/ 2> /dev/null

# Comprobar si el paquete rsync está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s rsync 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "  rsync no está instalado. Iniciando su instalación..."
    echo ""
    apt-get -y update
    apt-get -y install rsync
    echo ""
  fi
#rsync -a --delete /Discos/HDD-CopSeg/ /Discos/HDD-CopSegExt

rsync -av $CarpetaBD1 $vCarpetaCopSeg/RVN/CopSegBD/$vFechaDeEjecCopSeg/blocks
rsync -av $CarpetaBD2 $vCarpetaCopSeg/RVN/CopSegBD/$vFechaDeEjecCopSeg/chainstate

