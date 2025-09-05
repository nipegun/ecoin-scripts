#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para crear carteras y comprobar balances en Debian
#
# El objetivo de este script es demostrar que la randomización no es tan aleatoria y, por tanto, BTC es inseguro.
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/refs/heads/main/BIP39/bash/Electrum-CrearCarteraYComprobarBalance.sh | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/refs/heads/main/BIP39/bash/Electrum-CrearCarteraYComprobarBalance.sh | sed 's-sudo--g' | bash
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/refs/heads/main/BIP39/bash/Electrum-CrearCarteraYComprobarBalance.sh | nano -
# ----------

# Comprobar si el paquete curl está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s curl 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo -e "${cColorRojo}  El paquete curl no está instalado. Iniciando su instalación...${cFinColor}"
    echo ""
    sudo apt-get -y update
    sudo apt-get -y install curl
    echo ""
  fi

# Comprobar si el paquete jq está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s jq 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo -e "${cColorRojo}  El paquete jq no está instalado. Iniciando su instalación...${cFinColor}"
    echo ""
    sudo apt-get -y update
    sudo apt-get -y install jq
    echo ""
  fi

# Definir variables
  vRutaACarpetaDeCarteras="/mnt/c/Carteras" # Sin / final
  sudo mkdir -p "$vRutaACarpetaDeCarteras"
  sudo chmod 777 "$vRutaACarpetaDeCarteras"

# Correr el bucle hasta encontrar balance distinto de cero
  while true; do

    # Fecha/hora única para cada wallet
    vFechaDeEjec=$(date +a%Ym%md%d@%T)

    # Crear y cargar cartera
    ./run_electrum -w "$vRutaACarpetaDeCarteras"/"$vFechaDeEjec".wallet create
    ./run_electrum -w "$vRutaACarpetaDeCarteras"/"$vFechaDeEjec".wallet load_wallet

    # Comprobar balance
    vBalance=$(./run_electrum -w "$vRutaACarpetaDeCarteras"/"$vFechaDeEjec".wallet getbalance | jq -r '.confirmed')
    vSeed=$(cat "$vRutaACarpetaDeCarteras"/"$vFechaDeEjec".wallet | jq -r '.keystore.seed')

    if [[ "$vBalance" -eq 0 ]]; then
      mv -f "$vRutaACarpetaDeCarteras"/"$vFechaDeEjec".wallet "$vRutaACarpetaDeCarteras"/0-"$vSeed".wallet
    else
      mv -f "$vRutaACarpetaDeCarteras"/"$vFechaDeEjec".wallet "$vRutaACarpetaDeCarteras"/"$vBalance"-"$vSeed".wallet
      break
    fi

    #sleep 1 # Pausa para no saturar CPU

  done

