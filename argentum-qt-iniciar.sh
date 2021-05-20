#!/bin/bash

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Iniciando argentum-qt..."
echo ""
$CarpetaHome/scripts/c-scripts/argentum-daemon-parar.sh
sleep 5
$CarpetaHome/CoresCripto/ARG/bin/argentum-qt

