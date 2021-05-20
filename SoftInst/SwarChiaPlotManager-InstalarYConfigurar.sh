#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-----------------------------------------------------------------------
#  Script de NiPeGun para instalar y configurar Swar-Chia-Plot-Manager
#-----------------------------------------------------------------------

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
   ## Borrar todos los trabajos
      sed -i -e '/- name: micron/,$d' $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml

mkdir -p $CarpetaHome/Chia/Siembras 2> /dev/null
mkdir -p $CarpetaHome/Chia/Parcelas 2> /dev/null

echo ""                                                    >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "-name: default-home"                                 >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  max_plots: 150"                                    >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  temporary_directory: $CarpetaHome/Chia/Siembras"   >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  temporary2_directory:"                             >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  destination_directory: $CarpetaHome/Chia/Parcelas" >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  size: 32"                                          >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  bitfield: true"                                    >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  threads: 4"                                        >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  buckets: 128"                                      >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  memory_buffer: 4192"                               >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
echo "  max_concurrent: 6"                                 >> $CarpetaHome/Swar-Chia-Plot-Manager/config.yaml
    
    max_concurrent_with_start_early: 7
    initial_delay_minutes: 0
    stagger_minutes: 60
    max_for_phase_1: 3
    concurrency_start_early_phase: 4
    concurrency_start_early_phase_delay: 0
    temporary2_destination_sync: false
    exclude_final_directory: false
    skip_full_destinations: true
    unix_process_priority: 10
    windows_process_priority: 32
    enable_cpu_affinity: false
    cpu_affinity: [ 0, 1, 2, 3, 4, 5 ]
