#!/bin/bash

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Iniciando chia-blockchain..."
echo ""
$CarpetaHome/scripts/c-scripts/chia-daemon-parar.sh
sleep 5
$CarpetaHome/CoresCripto/XCH/bin/chia-blockchain %U

