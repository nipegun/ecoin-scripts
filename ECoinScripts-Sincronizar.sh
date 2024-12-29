#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para sincronizar los ecoin-scripts
#
# Ejecución remota para usuario normal con permiso sudo:
#   curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/refs/heads/main/ECoinScripts-Sincronizar.sh | bash
#
# Ejecución remota con el usuario root:
#   curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/refs/heads/main/ECoinScripts-Sincronizar.sh | sed 's-sudo--g'| bash
# ----------

# Definir variables de color
  vColorAzul="\033[0;34m"
  vColorAzulClaro="\033[1;34m"
  vColorVerde='\033[1;32m'
  vColorRojo='\033[1;31m'
  vFinColor='\033[0m'

# Comprobar si hay conexión a Internet antes de sincronizar los d-scripts
  # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
    if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
      echo ""
      echo -e "${vColorRojo}  El paquete wget no está instalado. Iniciando su instalación...${FinColor}"
      echo ""
      sudo apt-get -y update
      sudo apt-get -y install wget
    fi
  wget -q --tries=10 --timeout=20 --spider https://github.com

  if [[ $? -eq 0 ]]; then
    # Sincronizar c-scripts
      echo ""
      echo -e "${vColorAzulClaro}  Sincronizando los ecoin-scripts con las últimas versiones y descargando nuevos ecoin-scripts si es que existen...${vFinColor}"
      echo ""
      rm ~/scripts/ecoin-scripts -R 2> /dev/null
      mkdir ~/scripts 2> /dev/null
      cd ~/scripts
      # Comprobar si el paquete git está instalado. Si no lo está, instalarlo.
        if [[ $(dpkg-query -s git 2>/dev/null | grep installed) == "" ]]; then
          echo ""
          echo -e "${vColorRojo}    El paquete git no está instalado. Iniciando su instalación...${vFinColor}"
          echo ""
          sudo apt-get -y update > /dev/null
          sudo apt-get -y install git
          echo ""
        fi
      git clone --depth=1 https://github.com/nipegun/ecoin-scripts
      echo ""
      echo "  Borrando archivos innecesarios..."
      echo ""
      rm ~/scripts/ecoin-scripts/.git -R 2> /dev/null
      echo ""
      echo "  Asignando permisos de ejecución a todos los scripts..."
      echo ""
      find ~/scripts/ecoin-scripts/ -type f -iname "*.sh" -exec chmod +x {} \;
      echo ""
      echo -e "${vColorVerde}    ecoin-scripts sincronizados correctamente.${vFinColor}"
      echo ""
    # Crear los alias
      mkdir -p ~/scripts/ecoin-scripts/Alias/
      ~/scripts/ecoin-scripts/ECoinScripts-CrearAlias.sh
      find ~/scripts/ecoin-scripts/Alias -type f -exec chmod +x {} \;
  else
    echo ""
    echo -e "${vColorRojo}  No se pudo iniciar la sincronización de los ecoin-scripts porque no se detectó conexión a Internet.${vFinColor}"
    echo ""
  fi

