
# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para hacer copia de seguridad de la cadena de bloques de chia
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/c-scripts/main/CopSeg-XCH-CadenaDeBloques.sh | bash
# ----------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

# Definir la carpeta de usuario
  # Ver si la variable de entorno HOME termina con una /
     vCarpetaUsuario="$HOME"
     if [[ "$vCarpetaUsuario" == */ ]]; then
       # Quitarle la /
       vCarpetaUsuario=${vCarpetaUsuario%?}
     fi

# Definir la versión de la base de datos
  vVersRedPrinc=v2

# Definir la fecha de la copia de seguridad
  vFechaCopia=$(date +A%YM%mD%d@%T)

# Definir la carpeta de destino
  vCarpDestinoCopSeg="/CopSeg/Chia/$vFechaCopia/.chia/mainnet/db"

# Crear la carpeta de destino, por las dudas
  mkdir -p $vCarpDestinoCopSeg 2> /dev/null

# Comprobar si el paquete sqlite3 está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s sqlite3 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "  sqlite3 no está instalado. Iniciando su instalación..."
    echo ""
    apt-get -y update > /dev/null
    apt-get -y install sqlite3
    echo ""
  fi

# Ejecutar la copia de seguridad
  echo ""
  echo "  Ejecutando copia de seguridad de la cadena de bloques de Chia..."
  echo ""
  sqlite3 $vCarpetaUsuario/.chia/mainnet/db/blockchain_"$vVersRedPrinc"_mainnet.sqlite "vacuum into '$vCarpDestinoCopSeg/blockchain_"$vVersRedPrinc"_mainnet.sqlite'"

