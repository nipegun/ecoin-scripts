#!/bin/bash

vUsuarioNoRoot="nipegun"

# Definir constantes de color
  cColorAzul="\033[0;34m"
  cColorAzulClaro="\033[1;34m"
  cColorVerde='\033[1;32m'
  cColorRojo='\033[1;31m'
  # Para el color rojo también:
    #echo "$(tput setaf 1)Mensaje en color rojo. $(tput sgr 0)"
  cFinColor='\033[0m'

# Notificar inicio de ejecución del script
  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de notificación de saldo de cartera de Chia...${cFinColor}"
  echo ""

# Definir la ubicación del ejecutable
  echo ""
  echo "    Determinando la ruta hasta el ejecutable de chia..."
  if [ -f '/opt/chia/resources/app.asar.unpacked/daemon/chia' ]; then
    vCaminoAlEjecutable="/opt/chia/resources/app.asar.unpacked/daemon/chia"
    echo ""
    echo "      El ejecutable de chia está en: $vCaminoAlEjecutable"
    echo ""
  else
    vCaminoAlEjecutable="/home/$vUsuarioNoRoot/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia"
    echo ""
    echo "      El ejecutable de chia está en: $vCaminoAlEjecutable"
    echo ""
  fi
# Borrar el archivo anterior
  touch /tmp/ChiaSaldo.txt
  chmod 777 /tmp/ChiaSaldo.txt
# Comprobar cartera
  su - $vUsuarioNoRoot -c "$vCaminoAlEjecutable wallet show | grep 'Total Balance' | head -n1 | grep -v ending | cut -d':' -f2 | sed 's- --g' | cut -d'x' -f1 > /tmp/ChiaSaldo.txt"
# Guardar el balance de la cartera en una variable
  vSaldoCartera=$(cat /tmp/ChiaSaldo.txt)
# Enviar mensaje si el saldo de la cartera cambia
  echo ""
  echo "    El saldo de la cartera es: $vSaldoCartera."
  echo ""
  if [[ $vSaldoCartera != "" ]]; then
    #/root/scripts/Telegram-EnviarHTML.sh "<b>Estado de cartera de Chia de <a href='tg://user?id=29421797'>NiPeGun</a>:</b>%0A  Versión de nodo: $ChiaVers %0A  Balance de cartera: $ChiaSaldo %0A  Cantidad de parcelas: $ChiaParc %0A  Espacio de parcelas: $ChiaEspac "
     /root/scripts/Telegram-EnviarHTML.sh "<b>Balance de la cartera de Chia:</b>%0A  Balance de cartera: $vSaldoCartera %0A "
     # Actualizar este archvo para adaptar al nuevo saldo
       sed -i -e 's|$vChiaSaldo != ""|$vChiaSaldo != "'"$vSaldoCartera"'"|g' /root/scripts/xch-Cartera-AvisarDeCambioDeSaldo.sh
  fi

