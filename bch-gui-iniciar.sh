#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para iniciar la cartera gráfica de bitcoin cash
# ----------

# Ver si la variable de entorno HOME termina con una /
  vCarpetaHome="$HOME"
  if [[ "$vCarpetaHome" == */ ]]; then
    # Quitarle la /
    vCarpetaHome=${vCarpetaHome%?}
  fi

# Parar el daemon
  chmod +x $vCarpetaHome/scripts/c-scripts/bch-daemon-parar.sh 2> /dev/null
           $vCarpetaHome/scripts/c-scripts/bch-daemon-parar.sh
  sleep 5

# Iniciar el nodo gráfico
  echo ""
  echo "  Iniciando bitcoin-qt..."
  echo ""
  chmod +x $vCarpetaHome/Cryptos/BCH/bin/bitcoin-cli  2> /dev/null
  chmod +x $vCarpetaHome/Cryptos/BCH/bin/bitcoin-qt   2> /dev/null
  chmod +x $vCarpetaHome/Cryptos/BCH/bin/bitcoind     2> /dev/null
           $vCarpetaHome/Cryptos/BCH/bin/bitcoin-qt

