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
$CarpetaHome/scripts/litecoin-daemon-parar.sh
sleep 5
$CarpetaHome/CoresCrypto/LTC/bin/litecoin-qt
chmod +x $CarpetaHome/scripts/litecoin-qt-iniciar.sh

