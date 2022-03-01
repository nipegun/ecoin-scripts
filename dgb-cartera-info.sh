#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-----------------------------------------------------------------
#  Script de NiPeGun para mostrar info de la cartera de digibyte 
#-----------------------------------------------------------------

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Mostrando info de la cartera DigiByte..."
echo ""
## Comprobar si el paquete jq está instalado. Si no lo está, instalarlo.
   if [[ $(dpkg-query -s jq 2>/dev/null | grep installed) == "" ]]; then
     echo ""
     echo "  jq no está instalado. Iniciando su instalación..."
     echo ""
     apt-get -y update
     apt-get -y install jq
     echo ""
   fi
$CarpetaHome/Cryptos/RVN/bin/digibyte-cli getwalletinfo | jq

