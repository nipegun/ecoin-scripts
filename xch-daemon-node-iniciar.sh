#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para iniciar el nodo de chia
# ----------

# Ver si la variable de entorno HOME termina con una /
  CarpetaHome="$HOME"
  if [[ "$CarpetaHome" == */ ]]; then
    # Quitarle la /
      CarpetaHome="${CarpetaHome%?}"
  fi

# Notificar inicio de ejecución del script
  echo ""
  echo "  Iniciando el nodo de chia (si es que no está activo)..."
  echo ""

# Iniciar el nodo en modo daemon
  # Comprobar en donde está instalado el nodo
    if [ -f "$CarpetaHome"/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia ]; then
      chmod +x $CarpetaHome/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia 2> /dev/null
      $CarpetaHome/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia start node
    else
      chmod +x /opt/chia/resources/app.asar.unpacked/daemon/chia 2> /dev/null
      /opt/chia/resources/app.asar.unpacked/daemon/chia start node
    fi

