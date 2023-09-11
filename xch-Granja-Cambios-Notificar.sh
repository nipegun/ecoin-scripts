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
  echo -e "${cColorAzulClaro}  Iniciando el script de notificación de cambios de la granja de Chia...${cFinColor}"
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
  touch /tmp/ChiaBalanc.txt
  touch /tmp/ChiaVers.txt
  touch /tmp/ChiaParc.txt
  chmod 777 /tmp/ChiaBalanc.txt
  chmod 777 /tmp/ChiaVers.txt
  chmod 777 /tmp/ChiaParc.txt

# Comprobar cartera
  su - $vUsuarioNoRoot -c "$vCaminoAlEjecutable wallet show | grep 'Total Balance' | head -n1 | grep -v ending | cut -d':' -f2 | sed 's- --g' | cut -d'x' -f1 > /tmp/ChiaBalanc.txt"

# Guardar el balance de la cartera en una variable
  vChiaSaldo=$(cat /tmp/ChiaBalanc.txt)

# Enviar mensaje si el saldo de la cartera cambia
  if [[ $vChiaSaldo != "" ]]; then
    # Versión de Chia instalada
      su - $vUsuarioNoRoot -c "$vCaminoAlEjecutable version > /tmp/ChiaVers.txt"
      vChiaVers=$(cat /tmp/ChiaVers.txt)
    # Plots
      su - $vUsuarioNoRoot -c "$vCaminoAlEjecutable farm summary | grep lots | head -n1 > /tmp/ChiaParc.txt"
      vChiaParc=$(cat /tmp/ChiaParc.txt | cut -d'p' -f1 | sed 's/ //g')
    # Espacio
      vChiaEspac=$(cat /tmp/ChiaParc.txt | cut -d':' -f2)
    #/root/scripts/ParaEsteDebian/Telegramear-HTML.sh "<b>Estado de la granja de Chia de <a href='tg://user?id=29421797'>NiPeGun</a>:</b>%0A  Versión de nodo: $ChiaVers %0A  Balance de cartera: $ChiaSaldo %0A  Cantidad de parcelas: $ChiaParc %0A  Espacio de parcelas: $ChiaEspac "
     /root/scripts/ParaEsteDebian/Telegramear-HTML.sh "<b>Estado de la granja de Chia:</b>%0A  Versión de nodo: $vChiaVers %0A  Balance de la granja: $vChiaSaldo %0A  Cantidad de parcelas: $vChiaParc %0A  Espacio de parcelas: $vChiaEspac "
     # Actualizar este archvo para adaptar al nuevo saldo
       sed -i -e 's|$vChiaSaldo != ""|$vChiaSaldo != "'"$vChiaSaldo"'"|g' /root/scripts/c-scripts/xch-Granja-Cambios-Notificar.sh
  fi

