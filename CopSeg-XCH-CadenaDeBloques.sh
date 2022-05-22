
# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-------------------------------------------------------------------------------------------------
#  Script de NiPeGun para hacer copia de seguridad de la cadena de bloques de chia
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/c-scripts/main/CScripts-Sincronizar.sh | bash
#-------------------------------------------------------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

vFechaCopia=
vCarpetaUsuario=
vUbicBD="$vCarpetaUsuario"
vCarpDestinoCopSeg="/CopSeg/Chia/$vFechaCopia/.chia/mainnet/db"
vVersRedPrinc=v2
mkdir -p $vCarpDestinoCopSeg 2> /dev/null

# Comprobar si el paquete sqlite está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s sqlite 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "  sqlite no está instalado. Iniciando su instalación..."
    echo ""
    apt-get -y update > /dev/null
    apt-get -y install sqlite
    echo ""
  fi

sqlite3 $vCarpetaHome/.chia/mainnet/db/blockchain_$vVersRedPrinc_mainnet.sqlite "vacuum into '$vCarpDestinoCopSeg/blockchain_$vVersRedPrinc_mainnet.sqlite'"

