#!/usr/bin/env python3

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# Requisitos:
#   sudo apt -y update; sudo apt -y install python3-pip; sudo pip3 install mnemonic --break-system-packages

from itertools import permutations, islice
from mnemonic import Mnemonic
from multiprocessing import Pool, cpu_count
import signal
import sys

# Variables globales para cada proceso del pool
vValidador = None
vIdioma = "english"

def fInitValidador():
  global vValidador
  vValidador = Mnemonic(vIdioma)

def fEsValida(vFrase):
  return vFrase if vValidador.check(vFrase) else None

def fBloques(iterable, cTamano):
  while True:
    vBloque = list(islice(iterable, cTamano))
    if not vBloque:
      break
    yield vBloque

def fGenerarYGuardarPermutacionesValidas(aPalabras, cLongitud, vArchivoSalida, cTamanioBloque=100000, cProcesos=4):
  print(f"[*] Usando {cProcesos} procesos y bloques de {cTamanioBloque} permutaciones...")
  vTotal = 0
  vValidas = 0
  vPermutaciones = permutations(aPalabras, cLongitud)

  try:
    with open(vArchivoSalida, "w") as vOut:
      for aBloque in fBloques(vPermutaciones, cTamanioBloque):
        with Pool(processes=cProcesos, initializer=fInitValidador) as vPool:
          for vResultado in vPool.imap_unordered(fEsValida, (" ".join(p) for p in aBloque), chunksize=500):
            vTotal += 1
            if vResultado:
              #print(f"[✔] Válida: {vResultado}")
              vValidas += 1
              vOut.write(vResultado + "\n")

  except KeyboardInterrupt:
    print("\n[!] Interrupción detectada. Terminando ejecución...")
    vPool.terminate()
    vPool.join()
    sys.exit(1)

  print(f"[✓] Validación terminada. De {vTotal} permutaciones procesadas, {vValidas} son válidas.")
  print(f"[→] Frases válidas guardadas en {vArchivoSalida}")

if __name__ == "__main__":
  print("  Idiomas soportados por BIP39:")
  print("  english, spanish, french, italian, japanese, chinese_simplified, chinese_traditional, korean, czech\n")
  vIdiomaSeleccionado = input("  Ingrese el idioma de la frase (por defecto: english):\n  > ").strip().lower()
  if vIdiomaSeleccionado:
    vIdioma = vIdiomaSeleccionado

  vInput = input("\n  Ingrese las 12 palabras separadas por espacio:\n  Por ejemplo: abandon baby cabbage dad eager fabric gadget habit ice jacket kangaroo lab \n  > ").strip()
  aPalabras = vInput.split()

  if len(aPalabras) != 12:
    print(f"[✗] Error: Se esperaban 12 palabras, pero se recibieron {len(aPalabras)}.")
    exit(1)

  cLongitudPermutacion = 12
  vArchivoDeValidas = "PermutacionesUsables.txt"

  print("[*] Generando permutaciones y validando con control de memoria...")
  fGenerarYGuardarPermutacionesValidas(aPalabras, cLongitudPermutacion, vArchivoDeValidas)
