#!/bin/bash

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Iniciando monero-gui..."
echo ""
$CarpetaHome/scripts/c-scripts/monero-daemon-parar.sh
sleep 5
$CarpetaHome/CoresCripto/XMR/bin/monero-wallet-gui %u

