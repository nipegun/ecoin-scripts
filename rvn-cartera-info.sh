#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#--------------------------------------------------------------
#  Script de NiPeGun para mostrar info de la cartera de raven 
#--------------------------------------------------------------

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

echo ""
echo "  Mostrando info de la cartera Raven..."
echo ""
# Comprobar si el paquete jq está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s jq 2>/dev/null | grep installed) == "" ]]; then
    apt-get -y update      2> /dev/null
    apt-get -y install jq  2> /dev/null
  fi
chmod +x $CarpetaHome/Cryptos/RVN/bin/raven-cli 2> /dev/null
$CarpetaHome/Cryptos/RVN/bin/raven-cli getwalletinfo | jq

