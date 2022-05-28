#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para mostrar el estado de la red de Chia
# ----------

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Mostrando estado de la red de Chia..."
echo ""
chmod +x $CarpetaHome/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia
$CarpetaHome/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia netspace

