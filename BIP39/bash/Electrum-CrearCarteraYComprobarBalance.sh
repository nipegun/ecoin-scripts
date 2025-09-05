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
#   curl -sL x | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL x | sed 's-sudo--g' | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' x | bash
#
# Ejecución remota con parámetros:
#   curl -sL x | bash -s Parámetro1 Parámetro2
#
# Bajar y editar directamente el archivo en nano
#   curl -sL x | nano -
# ----------

# Definir variables
  vRutaACarpetaDeCarteras="/mnt/c/Carteras" # Sin / final

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
