#!/bin/bash

vUsuario="nipegun"

# Definir la ubicación del ejecutable
  if -f [ '/opt/chia/resources/app.asar.unpacked/daemon/chia' ]; then
    vCaminoAlEjecut="/opt/chia/resources/app.asar.unpacked/daemon/chia"
  else
    vCaminoAlEjecut="/home/$vUsuario/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia"
  fi
# Borrar el archivo anterior
  touch /tmp/ChiaBalanc.txt
  touch /tmp/ChiaVers.txt
  touch /tmp/ChiaParc.txt
  chmod 777 /tmp/ChiaBalanc.txt
  chmod 777 /tmp/ChiaVers.txt
  chmod 777 /tmp/ChiaParc.txt
# Comprobar cartera
  su - $vUsuario -c "$vCaminoAlEjecut wallet show | grep 'Total Balance' | grep -v ending | cut -d':' -f2 | cut -d' ' -f2 > /tmp/ChiaBalanc.txt"
# Guardar el balance de la cartera en una variable
  vChiaSaldo=$(cat /tmp/ChiaBalanc.txt)
# Enviar mensaje si el saldo de la cartera cambia
  if [[ $vChiaSaldo != "" ]]; then
    # Versión de Chia instalada
      su - $vUsuario -c "$vCaminoAlEjecut version > /tmp/ChiaVers.txt"
      vChiaVers=$(cat /tmp/ChiaVers.txt)
    # Plots
      su - $vUsuario -c "$vCaminoAlEjecut farm summary | grep lots | head -n1 > /tmp/ChiaParc.txt"
      vChiaParc=$(cat /tmp/ChiaParc.txt | cut -d'p' -f1 | sed 's/ //g')
    # Espacio
      vChiaEspac=$(cat /tmp/ChiaParc.txt | cut -d':' -f2)
    #/root/scripts/ParaEsteDebian/Telegram-EnviarHTML.sh "<b>Estado de la granja de Chia de <a href='tg://user?id=29421797'>NiPeGun</a>:</b>%0A  Versión de nodo: $ChiaVers %0A  Balance de cartera: $ChiaSaldo %0A  Cantidad de parcelas: $ChiaParc %0A  Espacio de parcelas: $ChiaEspac "
     /root/scripts/ParaEsteDebian/Telegram-EnviarHTML.sh "<b>Estado de la granja de Chia:</b>%0A  Versión de nodo: $vChiaVers %0A  Balance de la granja: $vChiaSaldo %0A  Cantidad de parcelas: $vChiaParc %0A  Espacio de parcelas: $vChiaEspac "
     # Actualizar este archvo para adaptar al nuevo saldo
       sed -i -e 's|$vChiaSaldo != ""|$vChiaSaldo != "'"$vChiaSaldo"'"|g' /root/scripts/xch-Granja-AvisarDeCambioDeSaldo.sh
  fi

