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

mkdir $CarpetaHome/SoftInst/
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
   pip install -r $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/requirements.txt

## Crear el archivo de configuración
   cp $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml.default $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml

## Modificar el archivo de configuración
   sed -i -e 's|chia_location:|chia_location:$CarpetaHome/CoresCripto/XCH/bin/resources/app.asar.unpacked/daemon/chia|g' $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
   sed -i -e 's|folder_path: S:\Chia\Logs\Plotter|folder_path: $CarpetaHome/Chia/Logs/|g'                                $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
   sed -i -e 's|max_concurrent: 10|max_concurrent: 6|g'                                                                  $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
   sed -i -e 's|max_for_phase_1: 3|max_for_phase_1: 5|g'                                                                 $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
   ## Borrar todos los trabajos
      sed -i -e '/- name: micron/,$d' $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml

echo ""                                                                     >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "-name: default-home"                                                  >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  max_plots: 100"                                                     >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  temporary_directory: $CarpetaHome/Chia/Siembras"                    >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  destination_directory: $CarpetaHome/Chia/Parcelas"                  >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  size: 32"                                                           >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  bitfield: true"                                                     >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  threads: 3"                                                         >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  buckets: 128"                                                       >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  memory_buffer: 4192"                                                >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  max_concurrent: 5"                                                  >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  max_concurrent_with_start_early: 5"                                 >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  initial_delay_minutes: 0"                                           >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  stagger_minutes: 5"                                                 >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  max_for_phase_1: 5"                                                 >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  concurrency_start_early_phase: 4"                                   >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  concurrency_start_early_phase_delay: 5"                             >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  temporary2_destination_sync: false"                                 >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  exclude_final_directory: false"                                     >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  skip_full_destinations: true"                                       >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  unix_process_priority: 10"                                          >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  windows_process_priority: 32"                                       >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  enable_cpu_affinity: false"                                         >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml
echo "  cpu_affinity: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ]" >> $CarpetaHome/SoftInst/Swar-Chia-Plot-Manager/config.yaml

mkdir -p $CarpetaHome/Chia/Siembras 2> /dev/null
mkdir -p $CarpetaHome/Chia/Parcelas 2> /dev/null

## Correr el programa
    python3 manager.py start
    python3 manager.py view

