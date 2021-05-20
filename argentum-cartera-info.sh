#!/bin/bash

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Mostrando info de la cartera Argentum..."
echo ""
$CarpetaHome/CoresCrypto/ARG/bin/argentum-cli getwalletinfo | jq

