#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para instalar y configurar la "cartera liviana" MyMonero (XMR)
#
# Ejecución remota:
#   curl -sL x | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' x | bash
# ----------

vUsuarioNoRoot="nipegun"

# Definir constantes de color
  cColorAzul="\033[0;34m"
  cColorAzulClaro="\033[1;34m"
  cColorVerde='\033[1;32m'
  cColorRojo='\033[1;31m'
  # Para el color rojo también:
    #echo "$(tput setaf 1)Mensaje en color rojo. $(tput sgr 0)"
  cFinColor='\033[0m'

# Comprobar si el script está corriendo como root
  if [ $(id -u) -ne 0 ]; then
    echo -e "${cColorRojo}  Este script está preparado para ejecutarse como root y no lo has ejecutado como root...${cFinColor}"
    exit
  fi

# Notificar el inicio de ejecución del script
  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de la cartera liviana de XCH...${cFinColor}"
  echo ""

# Obtener el número de la última versión estable desde github
  echo ""
  echo "    Obteniendo el número de la última versión estable desde github..." 
  echo ""
  vUltVersEstable=$(curl -sL https://github.com/mymonero/mymonero-app-js/releases/latest | sed 's->-\n-g' | grep "releases/tag/" | sed 's-releases/tag/-\nversion"-g' | grep version | grep -v name | head -n1 | cut -d '"' -f2 | cut -d 'v' -f2)
  echo ""
  echo "      La última versión estable es la: $vUltVersEstable."
  echo ""

# Obtener enlace de descarga de la última versión estable
  echo ""
  echo "    Obteniendo enlace de descarga de la versión $vUltVersEstable..." 
  echo ""
  vURLDelArchivoDeb=$(curl -sL https://github.com/mymonero/mymonero-app-js/releases | sed 's->-\n-g' | sed 's-href-\nhref-g' | grep $vUltVersEstable | grep href | grep AppImage | cut -d'"' -f2)
  if [[ "$vURLDelArchivoDeb" == "" ]]; then
    vURLDelArchivoDeb="https://github.com/mymonero/mymonero-app-js/releases/download/v$vUltVersEstable/MyMonero-$vUltVersEstable.AppImage"
  fi
  echo ""
  echo "      La URL de descarga es: https://github.com$vURLDelArchivoDeb."
  echo ""

# Crear carpeta de descarga
  echo ""
  echo "   Creando carpeta de descarga..." 
  echo ""
  rm -rf /root/SoftInst/Cryptos/XMR/ 2> /dev/null
  mkdir -p /root/SoftInst/Cryptos/XMR/ 2> /dev/null

# Descargar y descomprimir todos los archivos
  echo ""
  echo "    Descargando el paquete AppImage..." 
  echo ""
  # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
    if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
      echo ""
      echo "     El paquete wget no está instalado. Iniciando su instalación..."
      echo ""
      apt-get -y update
      apt-get -y install wget
      echo ""
    fi
  cd /root/SoftInst/Cryptos/XMR/
  rm -f /root/SoftInst/Cryptos/XMR/*.AppImage 2> /dev/null
  wget https://github.com/$vURLDelArchivoDeb -O /root/SoftInst/Cryptos/XMR/MyMonero.AppImage

# Instalar dependencias necesarias
  echo ""
  echo "    Instalando dependencias necesarias..." 
  echo ""

# Crear la carpeta para el usuario no root
  echo ""
  echo "    Creando la carpeta para el usuario no root..." 
  echo ""
  mkdir -p /home/$vUsuarioNoRoot/Cryptos/XMR/ 2> /dev/null
  rm -rf /home/$vUsuarioNoRoot/Cryptos/XMR/MyMonero/ 2> /dev/null
  mv /root/SoftInst/Cryptos/XMR/MyMonero.AppImage /home/$vUsuarioNoRoot/Cryptos/XMR/
  chown $vUsuarioNoRoot:$vUsuarioNoRoot /home/$vUsuarioNoRoot/Cryptos -R
  chmod +x /home/$vUsuarioNoRoot/Cryptos/XMR/MyMonero.AppImage

# Agregar aplicación al menú
  echo ""
  echo "    Agregando la aplicación gráfica al menú..." 
  echo ""
  mkdir -p /home/$vUsuarioNoRoot/.local/share/applications/ 2> /dev/null
  echo "[Desktop Entry]"                                                            > /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  echo "Name=xch GUI"                                                              >> /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  echo "Type=Application"                                                          >> /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  echo "Exec=/home/$vUsuarioNoRoot/scripts/c-scripts/xch-gui-iniciar.sh"            >> /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  echo "Terminal=false"                                                            >> /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  echo "Hidden=false"                                                              >> /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  echo "Categories=Cryptos"                                                        >> /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  echo "Icon=/home/$vUsuarioNoRoot/Cryptos/XCH/chia-blockchain/chia-blockchain.png" >> /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  chown $vUsuarioNoRoot:$vUsuarioNoRoot /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop
  gio set /home/$vUsuarioNoRoot/.local/share/applications/xch-gui.desktop "metadata::trusted" yes

# Crear el archivo de auto-ejecución
  echo ""
  echo "    Creando el archivo de autoejecución de chia-blockchain para el escritorio..." 
  echo ""
  mkdir -p /home/$vUsuarioNoRoot/.config/autostart/ 2> /dev/null
  echo "[Desktop Entry]"                                                            > /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  echo "Name=xch GUI"                                                              >> /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  echo "Type=Application"                                                          >> /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  echo "Exec=/home/$vUsuarioNoRoot/scripts/c-scripts/xch-gui-iniciar.sh"            >> /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  echo "Terminal=false"                                                            >> /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  echo "Hidden=false"                                                              >> /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  echo "Categories=Cryptos"                                                        >> /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  echo "Icon=/home/$vUsuarioNoRoot/Cryptos/XCH/chia-blockchain/chia-blockchain.png" >> /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  chown $vUsuarioNoRoot:$vUsuarioNoRoot /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop
  gio set /home/$vUsuarioNoRoot/.config/autostart/xch-gui.desktop "metadata::trusted" yes

# Instalar los c-scripts
  echo ""
  echo "    Instalando los c-scripts..." 
  echo ""
  su $vUsuarioNoRoot -c "curl --silent https://raw.githubusercontent.com/nipegun/c-scripts/main/CScripts-Instalar.sh | bash"
  find /home/$vUsuarioNoRoot/scripts/c-scripts/ -type f -iname "*.sh" -exec chmod +x {} \;

# Parar el daemon
  chmod +x /home/$vUsuarioNoRoot/scripts/c-scripts/xch-daemon-parar.sh
  su $vUsuarioNoRoot -c "/home/$vUsuarioNoRoot/scripts/c-scripts/xch-daemon-parar.sh"
  echo ""

# Reparar permisos
  echo ""
  echo "    Reparando permisos..." 
  echo ""
  chown $vUsuarioNoRoot:$vUsuarioNoRoot /home/$vUsuarioNoRoot/Cryptos/
  chown $vUsuarioNoRoot:$vUsuarioNoRoot /home/$vUsuarioNoRoot/Cryptos/XCH/ -R
  find /home/$vUsuarioNoRoot/Cryptos/XCH/ -type d -exec chmod 750 {} \;
  find /home/$vUsuarioNoRoot/Cryptos/XCH/chia-blockchain/ -type f -exec chmod +x {} \;
  find /home/$vUsuarioNoRoot/                             -type f -iname "*.sh" -exec chmod +x {} \;
  chown root:root /home/$vUsuarioNoRoot/Cryptos/XCH/chia-blockchain/chrome-sandbox
  chmod 4755      /home/$vUsuarioNoRoot/Cryptos/XCH/chia-blockchain/chrome-sandbox

# Notificar fin de la ejecución del script
  echo ""
  echo -e "${cColorVerde}  Ejecución del script, finalizada.${cFinColor}"
  echo ""
  echo -e "${cColorVerde}    Si estás ejecutando MyMonero dentro de un contenedor LXC de Proxmox${cFinColor}"
  echo -e "${cColorVerde}    acuérdate de activarle FUSE en las opciones del contenedor${cFinColor}"
  echo ""
