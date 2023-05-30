#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para sincronizar los c-scripts
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/c-scripts/main/CScripts-Sincronizar-UsuarioNoRoot.sh | bash
# ----------

# Definir variables de color
  vColorAzul="\033[0;34m"
  vColorAzulClaro="\033[1;34m"
  vColorVerde='\033[1;32m'
  vColorRojo='\033[1;31m'
  vFinColor='\033[0m'

# Ver si la variable de entorno HOME termina con una /
  vCarpetaHome="$HOME"
  if [[ "$vCarpetaHome" == */ ]]; then
    # Quitarle la /
    vCarpetaHome=${vCarpetaHome%?}
  fi

# Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
  if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "  wget no está instalado. Iniciando su instalación..."
    echo ""
    su root -c "apt-get -y update"
    su root -c "apt-get -y install wget"
  fi

# Comprobar si hay conexión a Internet antes de sincronizar los d-scripts
  wget -q --tries=10 --timeout=20 --spider https://github.com
  if [[ $? -eq 0 ]]; then
    echo ""
    echo -e "${vColorAzulClaro}  Sincronizando los c-scripts con las últimas versiones y descargando nuevos c-scripts si es que existen...${vFinColor}"
    echo ""
    rm $vCarpetaHome/scripts/c-scripts -R 2> /dev/null
    mkdir $vCarpetaHome/scripts 2> /dev/null
    cd $vCarpetaHome/scripts
    # Comprobar si el paquete git está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s git 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo "  git no está instalado. Iniciando su instalación..."
        echo ""
        su root -c "apt-get -y update > /dev/null"
        su root -c "apt-get -y install git"
        echo ""
      fi
    git clone --depth=1 https://github.com/nipegun/c-scripts
    mkdir -p $vCarpetaHome/scripts/c-scripts/Alias/
    rm $vCarpetaHome/scripts/c-scripts/.git -R 2> /dev/null
    find $vCarpetaHome/scripts/c-scripts/ -type f -iname "*.sh" -exec chmod +x {} \;
    $vCarpetaHome/scripts/c-scripts/CScripts-CrearAlias.sh
    find $vCarpetaHome/scripts/c-scripts/Alias -type f -exec chmod +x {} \;
    
    echo ""
    echo -e "${vColorVerde}  c-scripts sincronizados correctamente.${vFinColor}"
    echo ""
  else
    echo ""
    echo -e "${vColorRojo}  No se pudo iniciar la sincronización de los c-scripts porque no se detectó conexión a Internet.${vFinColor}"
    echo ""
  fi

