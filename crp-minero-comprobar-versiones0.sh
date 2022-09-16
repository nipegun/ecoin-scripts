#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para resetear el minero de utopia en el usuario root de Debian
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/c-scripts/main/crp-minero-comprobar-versiones.sh | bash
#
#  curl -s https://raw.githubusercontent.com/nipegun/c-scripts/main/crp-minero-comprobar-versiones.sh | sed 's-vUbicacMinero=/root/Cryptos/CRP/minero/-vUbicacMinero="/TuCarpetaDeMinero/"-g' | bash
# ----------

# Ubicación del minero
  vUbicacMinero=/root/Cryptos/CRP/minero/

# Determinar última version

  # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
    if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
      echo ""
      echo "  wget no está instalado. Iniciando su instalación..."
      echo ""
      apt-get -y update && apt-get -y install wget
      echo ""
    fi

  # Descargar el último archivo de instalación
    mkdir /tmp/utopiaminer/ 2> /dev/null
    rm -rf /tmp/utopiaminer/*
    cd /tmp/utopiaminer/
    wget https://update.u.is/downloads/uam/linux/uam-latest_amd64.deb

  # Descomprimir el archivo de instalación
    # Comprobar si el paquete binutils está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s binutils 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo "  binutils no está instalado. Iniciando su instalación..."
        echo ""
        apt-get -y update && apt-get -y install binutils
        echo ""
      fi
    ar x /tmp/utopiaminer/uam-latest_amd64.deb
    # Comprobar si el paquete tar está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s tar 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo "  tar no está instalado. Iniciando su instalación..."
        echo ""
        apt-get -y update
        apt-get -y install tar
        echo ""
      fi
    tar xfv /tmp/utopiaminer/data.tar.xz

# Obtener número de la última versión
  chmod +x /tmp/utopiaminer/opt/uam/uam 2> /dev/null
  /tmp/utopiaminer/opt/uam/uam --version | cut -d '-' -f2 | cut -d' ' -f3 > /tmp/latestutopiaversion
  
# Obtener número de la versión instalada
  chmod +x "$vUbicacMinero"uam 2> /dev/null
  "$vUbicacMinero"uam --version | cut -d '-' -f2 | cut -d' ' -f3 > /tmp/currentutopiaversion

# Borrar archivos sobrantes
  rm -rf /tmp/utopiaminer/*

# Comparar versión instalada con última versión
  if [ $(cat /tmp/latestutopiaversion) = $(cat /tmp/latestutopiaversion) ]; then
    echo "Las versiones coinciden."
    echo "Tienes instalada la versión $(cat /tmp/currentutopiaversion) y la última versión disponible es la $(cat /tmp/latestutopiaversion)"
  else
    echo "El número de versión instalada no coincide con la última versión disponible."
    echo "Tienes instalada la versión $(cat /tmp/currentutopiaversion) y la última versión disponible es la $(cat /tmp/latestutopiaversion)"
  fi
