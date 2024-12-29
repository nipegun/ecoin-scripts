#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para iniciar la cartera gráfica de litecoin
# ----------

# Ver si la variable de entorno HOME termina con una /
  CarpetaHome="$HOME"
  if [[ "$CarpetaHome" == */ ]]; then
    # Quitarle la /
    CarpetaHome=${CarpetaHome%?}
  fi

# Iniciar el proceso de lanzamiento gráfico del nodo
  echo ""
  echo "  Iniciando litecoin-qt..."
  echo ""
  chmod +x $CarpetaHome/scripts/ecoin-scripts/ltc-daemon-parar.sh 2> /dev/null
  $CarpetaHome/scripts/ecoin-scripts/ltc-daemon-parar.sh
  # Esperar 5 segundos
    sleep 5
  # Asignar permisos de ejecución
    chmod +x $CarpetaHome/Cryptos/LTC/bin/litecoin-cli    2> /dev/null
    chmod +x $CarpetaHome/Cryptos/LTC/bin/litecoin-qt     2> /dev/null
    chmod +x $CarpetaHome/Cryptos/LTC/bin/litecoin-tx     2> /dev/null
    chmod +x $CarpetaHome/Cryptos/LTC/bin/litecoin-wallet 2> /dev/null
    chmod +x $CarpetaHome/Cryptos/LTC/bin/litecoind       2> /dev/null
    chmod +x $CarpetaHome/Cryptos/LTC/bin/test_litecoin   2> /dev/null
  # Lanzar la app gráfica
    $CarpetaHome/Cryptos/LTC/bin/litecoin-qt

