#!/bin/bash

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Iniciando litecoin-qt..."
echo ""
$CarpetaHome/scripts/c-scripts/litecoin-daemon-parar.sh
sleep 5
$CarpetaHome/CoresCripto/LTC/bin/litecoin-qt

