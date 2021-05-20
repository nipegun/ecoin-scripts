#!/bin/bash

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Iniciando raven-qt..."
echo ""
$CarpetaHome/scripts/c-scripts/raven-daemon-parar.sh
sleep 5
/home/$UsuarioDaemon/CoresCripto/RVN/bin/raven-qt -min -testnet=0 -regtest=0

