#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para comprobar si el nodo de raven tiene la cadena de bloques sincronizada 
# ----------

# Ver si la variable de entorno HOME termina con una /
  vCarpetaHome="$HOME"
  if [[ "$vCarpetaHome" == */ ]]; then
    # Quitarle la /
    vCarpetaHome=${vCarpetaHome%?}
  fi

echo ""
echo "  Comprobando si el nodo raven tiene la cadena de bloques sincronizada..."
echo ""

# Comprobar si el paquete jq está instalado. Si no lo está, instalarlo.
  if  [[ $(dpkg-query -s jq 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo -e "${vColorRojo}    El paquete jq no está instalado. Iniciando su instalación...${vFinColor}"
    echo ""
    su root -c "apt-get -y update"
    su root -c "apt-get -y install jq"
  fi

# Dar permisos de ejecución a raven-cli (por si no los tiene)
  chmod +x $vCarpetaHome/Cryptos/RVN/bin/raven-cli 2> /dev/null

# Obtener información de la cartera
  $vCarpetaHome/Cryptos/RVN/bin/raven-cli getblockchaininfo | jq > /tmp/EstadoSincroBlockchainRaven.json

# Obtener la cantidad de headers totales de la cadena de bloques
  vHeaders=$(jq -r '.headers' /tmp/EstadoSincroBlockchainRaven.json)

# Obtener la cantidad de bloques descargados
  vBloques=$(jq -r '.blocks' /tmp/EstadoSincroBlockchainRaven.json)

# Comparar valores
  if (( $vHeaders = $vBloques )); then
    echo ""
    echo "  Resultado: Sincronizada."
    echo ""
    echo "    Headers totales: $vHeaders"
    echo "    Bloques descargados: $vBloques"
    echo ""
  elif
    echo ""
    echo "  Resultado: No sincronizada."
    echo ""
    echo "    Headers totales: $vHeaders"
    echo "    Bloques descargados: $vBloques"
    echo ""
  fi

