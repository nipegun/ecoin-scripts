#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para iniciar la cartera gráfica de argentum
# ----------

# Ver si la variable de entorno HOME termina con una /
  CarpetaHome="$HOME"
  if [[ "$CarpetaHome" == */ ]]; then
    # Quitarle la /
    CarpetaHome=${CarpetaHome%?}
  fi

# Iniciar el proceso de lanzamiento gráfico del nodo
  echo ""
  echo "  Iniciando argentum-qt..."
  echo ""
  # Parar primero el daemon
    chmod +x $CarpetaHome/scripts/ecoin-scripts/arg-daemon-parar.sh 2> /dev/null
             $CarpetaHome/scripts/ecoin-scripts/arg-daemon-parar.sh
  # Esperar 5 segundos
    sleep 5
  # Asignar permisos de ejecución
    chmod +x $CarpetaHome/Cryptos/ARG/bin/argentum-qt 2> /dev/null
  # Lanzar la app gráfica
    $CarpetaHome/Cryptos/ARG/bin/argentum-qt

