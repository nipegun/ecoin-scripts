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
  touch /tmp/SaldoCarteraChia.txt
  chmod 777 /tmp/SaldoCarteraChia.txt

# Comprobar cartera
  su - $vUsuarioNoRoot -c "$vCaminoAlEjecutable wallet show | grep 'Total Balance' | head -n1 | grep -v ending | cut -d':' -f2 | sed 's- --g' | cut -d'x' -f1 > /tmp/SaldoCarteraChia.txt"

# Guardar el balance de la cartera en una variable
  vSaldoCartera=$(cat /tmp/SaldoCarteraChia.txt)

# Enviar mensaje si el saldo de la cartera cambia
  echo ""
  echo "    El saldo de la cartera de Chia es: $vSaldoCartera."
  echo ""
  if [[ $vSaldoCartera != "" ]]; then
     /root/scripts/ParaEsteDebian/Telegramear-Texto.sh "El saldo de la cartera de Chia es: $vSaldoCartera"
     # Actualizar este archvo para adaptar al nuevo saldo
       sed -i -e 's|$vSaldoCartera != ""|$vSaldoCartera != "'"$vSaldoCartera"'"|g' /root/scripts/ecoin-scripts/xch-Cartera-Saldo-Cambio-Notificar-Por-Telegram.sh
  fi

