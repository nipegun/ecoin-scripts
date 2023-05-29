#!/bin/bash

Usuario="nipegun"

# Definir la ubicación del ejecutable
  CaminoAlEjecut="/home/$Usuario/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia"
# Borrar el archivo anterior
  touch /tmp/ChiaBalanc.txt
  touch /tmp/ChiaVers.txt
  touch /tmp/ChiaParc.txt
  chmod 777 /tmp/ChiaBalanc.txt
  chmod 777 /tmp/ChiaVers.txt
  chmod 777 /tmp/ChiaParc.txt
# Comprobar cartera
  su - $Usuario -c "$CaminoAlEjecut wallet show | grep 'Total Balance' | grep -v ending | cut -d':' -f2 | cut -d' ' -f2 > /tmp/ChiaBalanc.txt"
# Guardar el balance de la cartera en una variable
  ChiaSaldo=$(cat /tmp/ChiaBalanc.txt)
# Enviar mensaje si el saldo de la cartera cambia
  if [[ $ChiaSaldo != "" ]]; then
    # Versión de Chia instalada
      su - $Usuario -c "$CaminoAlEjecut version > /tmp/ChiaVers.txt"
      ChiaVers=$(cat /tmp/ChiaVers.txt)
    # Plots
      su - $Usuario -c "$CaminoAlEjecut farm summary | grep lots | head -n1 > /tmp/ChiaParc.txt"
      ChiaParc=$(cat /tmp/ChiaParc.txt | cut -d'p' -f1 | sed 's/ //g')
    # Espacio
      ChiaEspac=$(cat /tmp/ChiaParc.txt | cut -d':' -f2)
    #/root/scripts/Telegram-EnviarHTML.sh "<b>Estado de la granja de Chia de <a href='tg://user?id=29421797'>NiPeGun</a>:</b>%0A  Versión de nodo: $ChiaVers %0A  Balance de cartera: $ChiaSaldo %0A  Cantidad de parcelas: $ChiaParc %0A  Espacio de parcelas: $ChiaEspac "
     /root/scripts/Telegram-EnviarHTML.sh "<b>Estado de la granja de Chia:</b>%0A  Versión de nodo: $ChiaVers %0A  Balance de cartera: $ChiaSaldo %0A  Cantidad de parcelas: $ChiaParc %0A  Espacio de parcelas: $ChiaEspac "
     # Actualizar este archvo para adaptar al nuevo saldo
       sed -i -e 's|$ChiaSaldo != ""|$ChiaSaldo != "'"$ChiaSaldo"'"|g' /root/scripts/xch-Cartera-AvisarDeCambioDeSaldo.sh
  fi

