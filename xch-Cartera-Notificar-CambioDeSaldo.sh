#!/bin/bash

vUsuario="nipegun"

# Definir la ubicación del ejecutable
  if -f [ '/opt/chia/resources/app.asar.unpacked/daemon/chia' ]; then
    vCaminoAlEjecut="/opt/chia/resources/app.asar.unpacked/daemon/chia"
  else
    vCaminoAlEjecut="/home/$vUsuario/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia"
  fi
# Borrar el archivo anterior
  touch /tmp/ChiaSaldo.txt
  chmod 777 /tmp/ChiaSaldo.txt
# Comprobar cartera
  su - $vUsuario -c "$vCaminoAlEjecut wallet show | grep 'Total Balance' | grep -v ending | cut -d':' -f2 | cut -d' ' -f2 > /tmp/ChiaSaldo.txt"
# Guardar el balance de la cartera en una variable
  vChiaSaldo=$(cat /tmp/ChiaSaldo.txt)
# Enviar mensaje si el saldo de la cartera cambia
  if [[ $vChiaSaldo != "" ]]; then
    #/root/scripts/Telegram-EnviarHTML.sh "<b>Estado de cartera de Chia de <a href='tg://user?id=29421797'>NiPeGun</a>:</b>%0A  Versión de nodo: $ChiaVers %0A  Balance de cartera: $ChiaSaldo %0A  Cantidad de parcelas: $ChiaParc %0A  Espacio de parcelas: $ChiaEspac "
     /root/scripts/Telegram-EnviarHTML.sh "<b>Balance de la cartera de Chia:</b>%0A  Balance de cartera: $vChiaSaldo %0A "
     # Actualizar este archvo para adaptar al nuevo saldo
       sed -i -e 's|$vChiaSaldo != ""|$vChiaSaldo != "'"$vChiaSaldo"'"|g' /root/scripts/xch-Cartera-AvisarDeCambioDeSaldo.sh
  fi

