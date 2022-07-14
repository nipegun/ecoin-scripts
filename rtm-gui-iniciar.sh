#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para iniciar la cartera gráfica de raptoreum
# ----------

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Iniciando raptoreum-qt..."
echo ""
chmod +x $CarpetaHome/scripts/c-scripts/rtm-daemon-parar.sh 2> /dev/null
$CarpetaHome/scripts/c-scripts/rtm-daemon-parar.sh
sleep 5

chmod +x $CarpetaHome/Cryptos/RTM/bin/raptoreum-cli    2> /dev/null
chmod +x $CarpetaHome/Cryptos/RTM/bin/raptoreum-qt     2> /dev/null
chmod +x $CarpetaHome/Cryptos/RTM/bin/raptoreum-tx     2> /dev/null
chmod +x $CarpetaHome/Cryptos/RTM/bin/raptoreumd       2> /dev/null
$CarpetaHome/Cryptos/RTM/bin/raptoreum-qt

