#!/bin/bash

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Iniciando el daemon argentumd..."
echo ""
$CarpetaHome/CoresCrypto/ARG/bin/argentumd
