
## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

mkdir $CarpetaHome/SoftInst
cd $CarpetaHome/SoftInst/

# Comprobar si el paquete git está instalado. Si no lo está, instalarlo.
if [[ $(dpkg-query -s git 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "git no está instalado. Iniciando su instalación..."
    echo ""
    su root -c "apt-get -y update"
    su root -c "apt-get -y install git"
fi

git clone https://github.com/swar/Swar-Chia-Plot-Manager

## Comprobar si el paquete python3.7 está instalado. Si no lo está, instalarlo.
   if [[ $(dpkg-query -s python3.7 2>/dev/null | grep installed) == "" ]]; then
       echo ""
       echo "python3.7 no está instalado. Iniciando su instalación..."
       echo ""
       su root -c "apt-get -y update"
       su root -c "apt-get -y install python3.7"
   fi

## Comprobar si el paquete python3-venv está instalado. Si no lo está, instalarlo.
   if [[ $(dpkg-query -s python3-venv 2>/dev/null | grep installed) == "" ]]; then
       echo ""
       echo "python3-venv no está instalado. Iniciando su instalación..."
       echo ""
       su root -c "apt-get -y update"
       su root -c "apt-get -y install python3-venv"
   fi

## Crear el ambiente virtual
   python3 -m venv PythonVE-SCPM
   source $CarpetaHome/PythonVE-SCPM/bin/activate

## Instalar los requisitos
   pip install -r $CarpetaHome/Swar-Chia-Plot-Manager/requirements.txt

## Crear el archivo de configuración
   cp $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml.default $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml

## Modificar el archivo de configuración
   sed -i -e 's|chia_location:|chia_location:$CarpetaHome/CoresCripto/XCH/bin/resources/app.asar.unpacked/daemon/chia|g' $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
   sed -i -e 's|folder_path: S:\Chia\Logs\Plotter|folder_path: $CarpetaHome/Chia/Logs/|g' $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
   sed -i -e 's|max_concurrent: 10|max_concurrent: 6|g' $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
   sed -i -e 's|max_for_phase_1: 3|max_for_phase_1: 5|g' $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml


