#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para iniciar la cartera gráfica de ravencoin
# ----------

# Ver si la variable de entorno HOME termina con una /
  vCarpetaHome="$HOME"
  if [[ "$vCarpetaHome" == */ ]]; then
    # Quitarle la /
    vCarpetaHome=${vCarpetaHome%?}
  fi

# Iniciar el proceso de lanzamiento gráfico del nodo
  echo ""
  echo "  Iniciando raven-qt..."
  echo ""
  # Parar primero el daemon
    chmod +x $vCarpetaHome/scripts/ecoin-scripts/rvn-daemon-parar.sh 2> /dev/null
             $vCarpetaHome/scripts/ecoin-scripts/rvn-daemon-parar.sh
  # Esperar 5 segundos
    sleep 5
  # Asignar permisos de ejecución
    chmod +x $vCarpetaHome/Cryptos/RVN/bin/raven-cli  2> /dev/null
    chmod +x $vCarpetaHome/Cryptos/RVN/bin/raven-qt   2> /dev/null
    chmod +x $vCarpetaHome/Cryptos/RVN/bin/ravend     2> /dev/null
    chmod +x $vCarpetaHome/Cryptos/RVN/bin/test_raven 2> /dev/null
  # Lanzar la app gráfica
    #$vCarpetaHome/Cryptos/RVN/bin/raven-qt -min -testnet=0 -regtest=0
    $vCarpetaHome/Cryptos/RVN/bin/raven-qt

