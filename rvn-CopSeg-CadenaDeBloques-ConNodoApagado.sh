#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para hacer copia de seguridad de la cadena de bloques de chia con el nodo apagado
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/c-scripts/main/rvn-CopSeg-CadenaDeBloques-ConNodoApagado.sh | bash
# ----------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

FechaDeEjecCopSeg=$(date +A%Y-M%m-D%d@%T)

Usuario="nipegun"
CarpetaBD1="/home/$Usuario/.raven/blocks/"
CarpetaBD2="/home/$Usuario/.raven/chainstate/"

echo ""
echo -e "${ColorVerde}  Iniciando la copia de seguridad de la base de datos del nodo Raven...${FinColor}"
echo ""

mkdir -p /Host/RVN/CopSegBD/$FechaDeEjecCopSeg 2> /dev/null

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

rsync -av $CarpetaBD1 /Host/XCH/CopSegBD/$FechaDeEjecCopSeg
rsync -av $CarpetaBD2 /Host/XCH/CopSegBD/$FechaDeEjecCopSeg

