#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-----------------------------------------------------------------------------------------------------------
#  Script de NiPeGun para resetear el minero de utopia en el usuario root de Debian
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/c-scripts/main/crp-minero-resetear-en-root-ab.sh | bash
#-----------------------------------------------------------------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

DirCartera="02BA53D255C31B626D32EB14C57AC71B65B387BBE7E7F4A5290F849824DBB15A"

## Determinar la versión de Debian

   if [ -f /etc/os-release ]; then
       # Para systemd y freedesktop.org
       . /etc/os-release
       OS_NAME=$NAME
       OS_VERS=$VERSION_ID
   elif type lsb_release >/dev/null 2>&1; then
       # linuxbase.org
       OS_NAME=$(lsb_release -si)
       OS_VERS=$(lsb_release -sr)
   elif [ -f /etc/lsb-release ]; then
       # Para algunas versiones de Debian sin el comando lsb_release
       . /etc/lsb-release
       OS_NAME=$DISTRIB_ID
       OS_VERS=$DISTRIB_RELEASE
   elif [ -f /etc/debian_version ]; then
       # Para versiones viejas de Debian.
       OS_NAME=Debian
       OS_VERS=$(cat /etc/debian_version)
   else
       # Para el viejo uname (También funciona para BSD)
       OS_NAME=$(uname -s)
       OS_VERS=$(uname -r)
   fi

if [ $OS_VERS == "7" ]; then

  echo ""
  echo "-------------------------------------------------------------------------------------------"
  echo "  Iniciando el script para resetear el minero de Utopia instalado en Debian 7 (Wheezy)..."
  echo "-------------------------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "  Comandos para Debian 7 todavía no preparados. Prueba ejecutarlo en otra versión de Debian."
  echo ""

elif [ $OS_VERS == "8" ]; then

  echo ""
  echo "-------------------------------------------------------------------------------------------"
  echo "  Iniciando el script para resetear el minero de Utopia instalado en Debian 8 (Jessie)..."
  echo "-------------------------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "  Comandos para Debian 8 todavía no preparados. Prueba ejecutarlo en otra versión de Debian."
  echo ""

elif [ $OS_VERS == "9" ]; then

  echo ""
  echo "--------------------------------------------------------------------------------------------"
  echo "  Iniciando el script para resetear el minero de Utopia instalado en Debian 9 (Stretch)..."
  echo "--------------------------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "  Comandos para Debian 9 todavía no preparados. Prueba ejecutarlo en otra versión de Debian."
  echo ""

elif [ $OS_VERS == "10" ]; then

  echo ""
  echo "--------------------------------------------------------------------------------------------"
  echo "  Iniciando el script para resetear el minero de Utopia instalado en Debian 10 (Buster)..."
  echo "--------------------------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "  Comandos para Debian 10 todavía no preparados. Prueba ejecutarlo en otra versión de Debian."
  echo ""

elif [ $OS_VERS == "11" ]; then

  echo ""
  echo "-----------------------------------------------------------------------------------------------"
  echo "  Iniciando el script para resetear el minero de Crypton instalado en Debian 11 (Bullseye)..."
  echo "-----------------------------------------------------------------------------------------------"
  echo ""

  ## Terminar cualquier proceso del minero que pueda estar ejecutándose
     echo ""
     echo "  Terminando posibles procesos activos del antiguo minero..."
     echo ""
     ## Comprobar si el paquete psmisc está instalado. Si no lo está, instalarlo.
        if [[ $(dpkg-query -s psmisc 2>/dev/null | grep installed) == "" ]]; then
          echo ""
          echo "  psmisc no está instalado. Iniciando su instalación..."
          echo ""
          apt-get -y update
          apt-get -y install psmisc
          echo ""
        fi
     killall -9 uam

  ## Hacer copia de seguridad del archio uam.ini
     mv /root/.uam/uam.ini /root/

  ## Borrar todos los datos del anterior minero
     echo ""
     echo "  Borrando todos los datos del anterior minero..."
     echo ""
     rm -rf /root/.uam/*

## Preparar el archivo .ini del nuevo minero
     echo ""
     echo "  Preparando el archivo .ini del nuevo minero..."
     echo ""
     IPYPuerto=$(cat /root/uam.ini | grep listens)
     echo "[net]"       > /root/uam.ini
     echo "$IPYPuerto" >> /root/uam.ini
     mv /root/uam.ini /root/.uam/

  ## Re-escribir la dirección de cartera
     sed -i -e "s|C24C4B77698578B46CDB1C109996B0299984FEE46AAC5CD6025786F5C5C61415|$DirCartera|g" ~/Cryptos/CRP/minero/Minar.sh

  # Preparar /root/.bash_history
    echo 'apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove'                                           > /root/.bash_history
    echo "curl -s https://raw.githubusercontent.com/nipegun/c-scripts/main/crp-minero-resetear-en-root-ab.sh | bash"                            >> /root/.bash_history
    echo "curl -s https://raw.githubusercontent.com/nipegun/d-scripts/master/SoftInst/ParaCLI/Cryptos-CRP-Minero-InstalarOActualizar.sh | bash" >> /root/.bash_history

  ## Reiniciar el sistema
     echo ""
     echo "  Reiniciando el sistema..."
     echo ""
     shutdown -r now

  fi
  
fi

